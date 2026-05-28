import 'package:flutter/material.dart';
import 'package:flutter_final_project_kintkin/Pages/main_screen.dart';
import 'package:flutter_final_project_kintkin/Pages/register_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {

        // Loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Current logged in user
        final session = snapshot.data?.session;

        // User already logged in
        if (session != null) {
          return const MainScreen();
        }

        // User not logged in
        return const RegisterScreen();
      },
    );
  }
}