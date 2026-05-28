import 'package:flutter/material.dart';
import '../widgets/build_header.dart';
import '../widgets/price_details.dart';
import '../widgets/paymentMethod.dart';
import '../widgets/payment_finnish_button.dart';
import 'package:flutter_final_project_kintkin/models/event_model.dart';

class PaymentScreen extends StatefulWidget {
  final EventModel event;

  const PaymentScreen({
    super.key,
    required this.event,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreen();
}

class _PaymentScreen extends State<PaymentScreen> {
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
                    buildPaymentDetails(widget.event),
                    const SizedBox(height: 30),
                    PaymentMethodSection(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: PaymentFinnishButton(event: widget.event),
            ),
          ],
        ),
      ),
    );
  }
}
