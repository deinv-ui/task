import 'services/auth_service.dart';
import 'package:flutter/material.dart';
import 'login.dart';   // Your login screen
import 'homepage.dart'; // Your logged-in screen
class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: AuthService().getToken(),  // Check if a token exists
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData && snapshot.data != null) {
          return const Homepage(); // User is logged in
        } else {
          return const Login(); // User is not logged in
        }
      },
    );
  }
}