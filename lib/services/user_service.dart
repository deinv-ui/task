import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// lib/services/user_service.dart

class UserService {
  static const _baseUrl = 'https://reqres.in/api';
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<Map<String, dynamic>?> fetchUserProfile() async {
    final userId = await _secureStorage.read(key: 'user_id');
    if (userId == null) return null;

    final url = Uri.parse('$_baseUrl/users/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      return null;
    }
  }

  Future<bool> updateProfile(
    String userId,
    Map<String, dynamic> updates,
  ) async {
    final url = Uri.parse('$_baseUrl/users/$userId');
    final response = await http.put(
      url,
      body: json.encode(updates),
      headers: {'Content-Type': 'application/json'},
    );

    return response.statusCode == 200;
  }

  Future<String?> getAvatar() async {
    final profile = await fetchUserProfile();
    return profile?['avatar'];
  }

  Future<void> storeUserId(String userId) async {
    await _secureStorage.write(key: 'user_id', value: userId);
  }

  Future<Map<String, dynamic>?> getUserById(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/users/$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'];
    } else {
      return null;
    }
  }
}
