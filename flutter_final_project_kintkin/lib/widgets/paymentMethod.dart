import 'package:flutter/material.dart';
import '../widgets/PaymentOptions.dart';
class PaymentMethodSection extends StatefulWidget {
  const PaymentMethodSection({super.key});

  @override
  State<PaymentMethodSection> createState() => _PaymentMethodSectionState();
}

class _PaymentMethodSectionState extends State<PaymentMethodSection> {
  // Pindahkan data list dan variabel selection ke dalam State
  String _selectedMethod = 'gopay';

  final List<Map<String, dynamic>> _paymentMethods = [
    {'id': 'gopay', 'name': 'GoPay', 'color': Colors.green},
    {'id': 'ovo', 'name': 'OVO', 'color': Colors.purple},
    {'id': 'dana', 'name': 'DANA', 'color': Colors.blue},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Method',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF1B3A4A)),
        ),
        const SizedBox(height: 16),
        ..._paymentMethods.map((method) {
          return PaymentOptions(
            name: method['name'],
            brandColor: method['color'],
            isSelected: _selectedMethod == method['id'],
            onTap: () {
              setState(() {
                _selectedMethod = method['id'];
              });
            },
          );
        }),
      ],
    );
  }
}