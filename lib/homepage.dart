import 'login.dart';
import 'components/task_card.dart';
import 'services/user_service.dart';
import 'services/task_service.dart';
import 'package:flutter/material.dart';
import 'components/custom_bottom_navigation_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final UserService _userService = UserService();

  String? _email;
  String? _token;
  String? _avatar;
  String? _fullName;
  final TaskService _taskService = TaskService();
  List<Task> _tasks = [];
  bool _isLoading = true;
  String? _error;

  int _currentIndex = 2;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    try {
      final tasks = await _taskService.fetchTasks();
      setState(() {
        _tasks = tasks;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load tasks: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _loadUserData() async {
    try {
      final token = await _secureStorage.read(key: 'token');
      final idStr = await _secureStorage.read(key: 'userId');
      final id = idStr != null ? int.tryParse(idStr) : null;

      if (id == null) throw 'User ID not found';

      final userData = await _userService.getUserById(id);
      if (userData == null) throw 'User not found';

      setState(() {
        _token = token != null ? _maskToken(token) : null;
        _email = userData['email'];
        _avatar = userData['avatar'];
        _fullName = '${userData['first_name']} ${userData['last_name']}';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  String _maskToken(String token) {
    if (token.length <= 10) return '*' * token.length;
    return '${token.substring(0, 5)}...${token.substring(token.length - 5)}';
  }

  Future<void> signOut() async {
    await _secureStorage.deleteAll();
    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const Login()),
      );
    }
  }

  void _onNavBarTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: _avatar != null
                        ? NetworkImage(_avatar!)
                        : const NetworkImage('https://reqres.in/img/faces/2-image.jpg'),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _fullName ?? 'Loading...',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _email ?? '',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.notifications_none_outlined, size: 28),
                ],
              ),
              const SizedBox(height: 36),

              // Productivity Section
              const Text(
                'Productivity',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(child: Text('Bar Chart Placeholder')),
              ),
              const SizedBox(height: 36),

              // Recent Tasks
              const Text(
                'Recent Tasks',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),

              _isLoading
                  ? const Expanded(child: Center(child: CircularProgressIndicator()))
                  : _error != null
                      ? Expanded(child: Center(child: Text(_error!)))
                      : Expanded(
                          child: ListView.separated(
                            itemCount: _tasks.length,
                            itemBuilder: (context, index) {
                              final task = _tasks[index];
                              return TaskCard(
                                title: task.name,
                                subtitle: 'Year: ${task.year}',
                                onCheckboxTap: () {
                                  // Handle checkbox tap here if needed
                                },
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 16),
                          ),
                        ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onNavBarTap,
      ),
    );
  }
}
