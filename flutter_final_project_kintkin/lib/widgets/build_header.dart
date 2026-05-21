import 'package:flutter/material.dart';


Widget buildHeader(){
  return Center(
    child: Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color((0xFF1B3A4A)), width: 2.5),

          ),
          child: const Center(
            child: Text(
              '\$',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B3A4A),
                ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Payment Details',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B3A4A),
            ),
        ),
      ],
    ),
  );
}