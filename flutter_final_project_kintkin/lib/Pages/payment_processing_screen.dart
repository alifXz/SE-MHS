import 'package:flutter/material.dart';
import 'dart:async';
import 'PaymentComplete_screen.dart';
import 'package:flutter_final_project_kintkin/models/event_model.dart';

class PaymentProcessingScreen extends StatefulWidget {
  final EventModel event;

  const PaymentProcessingScreen({
    super.key,
    required this.event,
  });

  @override
  State<PaymentProcessingScreen> createState() =>
      _PaymentProcessingScreenState();
}

class _PaymentProcessingScreenState extends State<PaymentProcessingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => PaymentcompleteScreen(event: widget.event)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.black,
        backgroundColor: Colors.white,
      ),
    );
  }
}
