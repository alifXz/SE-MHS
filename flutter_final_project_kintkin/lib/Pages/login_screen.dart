import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
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
        Text('Kith & kin',
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