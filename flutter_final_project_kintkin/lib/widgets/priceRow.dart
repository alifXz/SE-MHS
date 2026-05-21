import 'package:flutter/material.dart';

Widget priceRow(String label, String value, {bool isBold = false}) {
    final style = TextStyle(
      fontSize: 15,
      fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
      color: isBold ? const Color(0xFF1B3A4A) : Colors.grey[600],
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value, style: style),
      ],
    );
  }