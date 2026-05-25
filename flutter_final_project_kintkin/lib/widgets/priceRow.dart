import 'package:flutter/material.dart';

Widget buildDetailRow(String label, int value, {bool isTotal = false}) {
  String valueString = "IDR ${value.toString()}";
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      // <--- Sudah diganti menjadi child
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? const Color(0xFF1B3A4A) : Colors.black54,
          ),
        ),
        Text(
          valueString,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal ? const Color(0xFF1B3A4A) : Colors.black87,
          ),
        ),
      ],
    ),
  );
}
