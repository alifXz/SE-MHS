import 'package:flutter/material.dart';

class AuthLogo extends StatelessWidget {
  const AuthLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const[
        SizedBox(
          height: 80,
          child: Center(
            child: Text(
              'k k',
              style: TextStyle(
                fontSize: 44,
                fontWeight: FontWeight.bold,
                letterSpacing: 8,
              ),
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
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