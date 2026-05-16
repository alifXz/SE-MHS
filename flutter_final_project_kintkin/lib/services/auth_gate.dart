import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_project_kintkin/Pages/main_screen.dart';
import 'package:flutter_final_project_kintkin/Pages/register_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // If Firebase is still validating the session token, show a loading spinner
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // If a user session exists, send them straight into the App Home
        if (snapshot.hasData) {
          return const MainScreen();
        }

        // Otherwise, they are unauthenticated—show them the Register Screen
        return const RegisterScreen();
      },
    );
  }
}
