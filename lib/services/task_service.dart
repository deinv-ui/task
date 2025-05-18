import 'dart:convert';
import 'package:http/http.dart' as http;

class TaskService {
  final String _url = 'https://reqres.in/api/unknown';

  Future<List<Task>> fetchTasks() async {
    try {
      final response = await http.get(Uri.parse(_url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        List<Task> tasks = [];
        for (var item in data['data']) {
          tasks.add(Task.fromJson(item));
        }
        return tasks;
      } else {
        throw Exception('Failed to load tasks');
      }
    } catch (e) {
      rethrow;
    }
  }
}

class Task {
  final int id;
  final String name;
  final int year;
  final String color;

  Task({
    required this.id,
    required this.name,
    required this.year,
    required this.color,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'],
      year: json['year'],
      color: json['color'],
    );
  }
}
