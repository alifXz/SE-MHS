import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final bool isSmall;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isSmall ? 39 : 40),
      decoration: BoxDecoration(
        color: const Color(0xFF333230), // Dark grey from your design
        borderRadius: BorderRadius.circular(35),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: isSmall ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          if (isSmall) ...[
            Icon(icon, color: const Color(0xFFEAD8A7), size: 58),
            const SizedBox(height: 17),
          ],
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            textAlign: isSmall ? TextAlign.center : TextAlign.left,
          ),
          SizedBox(height: isSmall ? 8 : 12),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: isSmall ? 22 : 38,
              fontWeight: FontWeight.bold,
              fontFamily: 'Serif',
            ),
            textAlign: isSmall ? TextAlign.center : TextAlign.left,
          ),
         
        ],
      ),
    );
  }
}