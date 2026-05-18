import 'package:flutter/material.dart';

class JoinButton extends StatefulWidget {
  const JoinButton({super.key});

  @override
  State<JoinButton> createState() => _JoinButtonState();
}

class _JoinButtonState extends State<JoinButton> {
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
          // onTap: (_) {
          //   setState(() => _pressing = false);
          //   Navigator.of(context).push(
          //     MaterialPageRoute(builder: (context) => const YourNextPage()),
          //   );
          // }, NANTI BUAT KE PAYMENT
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
              "Join Event",
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