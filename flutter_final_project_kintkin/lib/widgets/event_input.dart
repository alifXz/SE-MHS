import 'package:flutter/material.dart';

class EventName extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final IconData? suffixIcon;
  final int maxLines;
  final VoidCallback? onTap;
  final bool readOnly;
  final TextInputType? keyboardType;

  const EventName({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.suffixIcon,
    this.maxLines = 1,
    this.onTap,
    this.readOnly = false,
    this.keyboardType,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4A4A4A),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            readOnly: readOnly,
            onTap: onTap,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.black54),
              filled: true,
              fillColor: const Color(0xFFEEF2F4),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: Colors.black): null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(maxLines > 1 ? 20 : 30),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(maxLines > 1 ? 20 : 30),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(maxLines > 1 ? 20 : 30),
                borderSide: const BorderSide(color: Color(0xFF4A6472), width: 1.5),
              ),
            ),
          )
        ],
      ),
      );
  }
}