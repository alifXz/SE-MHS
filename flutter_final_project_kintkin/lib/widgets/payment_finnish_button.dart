import 'package:flutter/material.dart';
import 'package:flutter_final_project_kintkin/Pages/payment_processing_screen.dart';
import 'package:flutter_final_project_kintkin/models/event_model.dart';
import 'package:flutter_final_project_kintkin/services/supabase_service.dart';

class PaymentFinnishButton extends StatefulWidget {
  final EventModel event;

  const PaymentFinnishButton({
    super.key,
    required this.event,
  });

  @override
  State<PaymentFinnishButton> createState() =>
      _PaymentFinnishButtonState();
}

class _PaymentFinnishButtonState
    extends State<PaymentFinnishButton> {

  bool _pressing = false;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Color(0xFFEEEEEE),
            ),
          ),
        ),
        child: GestureDetector(
          onTapDown: (_) {
            if (!_loading) {
              setState(() => _pressing = true);
            }
          },

          onTapUp: (_) {
            if (!_loading) {
              setState(() => _pressing = false);
            }
          },

          onTapCancel: () {
            if (!_loading) {
              setState(() => _pressing = false);
            }
          },

          onTap: _loading
              ? null
              : () async {

                  setState(() {
                    _pressing = false;
                    _loading = true;
                  });

                  try {

                    // insert registration into supabase
                    await SupabaseService().joinEvent(
                      event: widget.event,
                    );

                    if (!context.mounted) return;

                    Navigator.of(context).pop();

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            PaymentProcessingScreen(
                          event: widget.event,
                        ),
                      ),
                    );

                  } catch (e) {

                    if (!context.mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Payment failed: $e',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );

                  } finally {

                    if (mounted) {
                      setState(() {
                        _loading = false;
                      });
                    }
                  }
                },

          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            padding: const EdgeInsets.symmetric(vertical: 16),

            decoration: BoxDecoration(
              color: _pressing
                  ? const Color(0xFF003049)
                  : Colors.transparent,

              border: Border.all(
                color: const Color(0xFF5A7CCB),
                width: 1.5,
              ),

              borderRadius: BorderRadius.circular(50),
            ),

            alignment: Alignment.center,

            child: _loading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    "Confirm Payment",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: _pressing
                          ? Colors.white
                          : Colors.black87,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}