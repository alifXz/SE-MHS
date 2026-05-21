import 'package:flutter/material.dart';
class PaymentOptions extends StatelessWidget {
  final String name;
  final Color brandColor;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentOptions({
    super.key,
    required this.name,
    required this.brandColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? const Color(0xFF1B3A4A) : Colors.transparent,
          width: 2,
        ),
      ),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: brandColor.withOpacity(0.2),
          child: Icon(Icons.account_balance_wallet, color: brandColor),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: Radio<bool>(
          value: true,
          groupValue: isSelected,
          activeColor: const Color(0xFF1B3A4A),
          onChanged: (_) => onTap(),
        ),
      ),
    );
  }
}