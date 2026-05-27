import 'package:flutter/material.dart';
import 'package:flutter_final_project_kintkin/Pages/payment_processing_screen.dart';
import 'package:flutter_final_project_kintkin/models/event_model.dart';

class PaymentFinnishButton extends StatefulWidget {
  final EventModel event;

  const PaymentFinnishButton({
    super.key,
    required this.event,
  });

  @override
  State<PaymentFinnishButton> createState() => _JoinButtonState();
}

class _JoinButtonState extends State<PaymentFinnishButton> {
  bool _pressing = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
        ),
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressing = true),
          onTapUp: (_) => setState(() => _pressing = false),
          onTap: () {
            setState(() => _pressing = false);
            
            // Sample event data to send to backend
            final eventData = {
              'eventName': 'Tech Conference 2026',
              'location': 'San Francisco, CA',
              'time': '2:30 PM',
              'date': '2026-05-25',
            };
            
            // Process data into backend
            // print('Processing event data: $eventData');
            // TODO: Call backend API to process event payment with this data
            // There is an API class inside services folder that can be used to fetch the api
            // Example: await paymentService.processEventPayment(eventData);
            
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PaymentProcessingScreen(event: widget.event),
                ),
            );
          }, 
          onTapCancel: () => setState(() => _pressing = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: _pressing ? const Color(0xFF003049) : Colors.transparent,
              border: Border.all(color: const Color(0xFF5A7CCB), width: 1.5),
              borderRadius: BorderRadius.circular(50),
            ),
            alignment: Alignment.center,
            child: Text(
              "Confirm Payment",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: _pressing ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }
}