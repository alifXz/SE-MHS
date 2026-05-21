
import 'package:flutter/material.dart';
import '../Pages/payment_screen.dart';
Widget _buildPaymentMethodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Method',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        // Loop list jadi tile - data-driven approach
        ..._paymentMethods.map((method) {
          return PaymentMethodTile(
            name: method['name'],
            brandColor: method['color'],
            isSelected: _selectedMethod == method['id'],
            onTap: () {
              // Inti dari radio behavior:
              // update _selectedMethod, semua tile auto rebuild
              setState(() {
                _selectedMethod = method['id'];
              });
            },
          );
        }),
      ],
    );
  }
