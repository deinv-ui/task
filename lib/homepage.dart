import 'login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  String? _email;
  String? _token;

  @override
  void initState() {
    super.initState();
    _loadSessionData();
  }

  Future<void> _loadSessionData() async {
    final email = await _secureStorage.read(key: 'email');
    final token = await _secureStorage.read(key: 'token');
    setState(() {
      _email = email;
      _token = token != null ? _maskToken(token) : null;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Homepage")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_email != null ? 'Email: $_email' : 'Email not found.'),
            const SizedBox(height: 10),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: signOut,
        child: const Icon(Icons.logout),
      ),
    );
  }
}
