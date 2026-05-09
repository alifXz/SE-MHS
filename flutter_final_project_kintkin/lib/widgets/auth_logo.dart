import 'package:flutter/material.dart';

class AuthLogo extends StatelessWidget {
  const AuthLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/kith&kin-logo.jpeg',
          height: 100,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 4),
        const Text(
          '-Kith & Kin',
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}