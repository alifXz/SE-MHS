import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String userName;
  const TopBar({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 10),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage('assets/images/kith&kin-logo.jpeg'),
            ),
            const SizedBox(width: 12),
            Text(
              userName,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_outlined,color: Colors.black),
            ),
            IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}