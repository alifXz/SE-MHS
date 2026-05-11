import 'package:flutter/material.dart';

Widget TopBar(){
  return Row(
    children: [
      //Profile Section(kiri atas)
      const CircleAvatar(
        radius: 24,
        backgroundImage: AssetImage('assets/images/kith&kin-logo.jpeg'),
      ),
      const SizedBox(width:12),
      const Text(
        '',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const Spacer(),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.notifications_outlined)
        ),
        IconButton(
        onPressed: () {},
        icon: const Icon(Icons.menu)
        ),
    ],
  );
}