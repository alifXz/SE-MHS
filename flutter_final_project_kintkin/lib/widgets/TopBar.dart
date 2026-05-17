import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String userName;

  const TopBar({
    super.key,
    required this.userName, // Requiring the username from parent
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage('assets/images/kith&kin-logo.jpeg'),
          ),
          const SizedBox(width: 12),
          Text(
            userName, // Dynamic text injection
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        ],
      ),
    );
  }
}
