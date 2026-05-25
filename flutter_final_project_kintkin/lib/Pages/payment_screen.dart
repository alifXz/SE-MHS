import 'package:flutter/material.dart';
import 'package:flutter_final_project_kintkin/widgets/join_event_button.dart';
import '../widgets/build_header.dart';
import '../widgets/price_details.dart';
import '../widgets/paymentMethod.dart';
import '../widgets/payment_finnish_button.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreen();
}

class _PaymentScreen extends State<PaymentScreen> {
  String? _selectedMethod;

  final int price = 50000;
  final int tax = 5000;
  final int serviceFee = 5000;

  int get _total => price + tax + serviceFee;

  final List<Map<String, dynamic>> _paymentMethods = [
    {'id': 'bca', 'name': 'BCA', 'color': Color(0xFF005BAA)},
    {'id': 'gopay', 'name': 'gopay', 'color': Color(0xFF00AED6)},
    {'id': 'ovo', 'name': 'OVO', 'color': Color(0xFF4C2A86)},
    {'id': 'card', 'name': 'Credit/Debit Card', 'color': Colors.grey},
  ];

  String _formatRupiah(int amount) {
    final str = amount.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buffer.write('.');
      buffer.write(str[i]);
    }
    return 'Rp ${buffer.toString()}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    buildHeader(),
                    const SizedBox(height: 30),
                    buildPaymentDetails(_total),
                    const SizedBox(height: 30),
                    PaymentMethodSection(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: PaymentFinnishButton(),
            ),
          ],
        ),
      ),
    );
  }
}
