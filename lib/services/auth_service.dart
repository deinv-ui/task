import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final _secureStorage = FlutterSecureStorage();

  // ReqRes base URL
  static const _baseUrl = 'https://reqres.in/api';

  // Sign-Up: Simulate user registration
  Future<bool> register(String email, String password) async {
    final url = Uri.parse('$_baseUrl/register');

    final response = await http.post(
      url,
      body: json.encode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final token = responseData['token']; // ReqRes returns a token on success
      if (token != null) {
        await _secureStorage.write(key: 'token', value: token);
        await _secureStorage.write(key: 'userId', value: '2');
        return true;
      }
    }

    return false;
  }

  // Login: Authenticate user
  Future<bool> signIn(String email, String password) async {
    final url = Uri.parse('$_baseUrl/login');

    final response = await http.post(
      url,
      body: json.encode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final token = responseData['token']; // ReqRes returns a token on success
      if (token != null) {
        await _secureStorage.write(key: 'token', value: token);
        await _secureStorage.write(key: 'userId', value: '2');
        return true;
      }
    }

    return false;
  }

  // Sign-out: Remove token from storage
  Future<void> signOut() async {
    await _secureStorage.delete(key: 'token');
  }

  // Get token (for authenticated user)
  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'token');
  }

  // Simulate fetching user profile (using the token)
  Future<Map<String, String>> getProfile() async {
    final token = await getToken();
    if (token != null) {
      return {"email": "user@example.com"}; // Return dummy email for now
    }
    return {"email": "No user found"};
  }
}
