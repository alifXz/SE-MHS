import 'package:flutter/material.dart';
import '../Pages/history_page.dart';
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
              child: const Text(
                "Menu",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            const Divider(height: 1),

            // Activity History
            ListTile(
              leading: const Icon(Icons.history, color: Colors.black54),
              title: const Text(
                "Activity History",
                style: TextStyle(fontSize: 15, color: Colors.black87),
              ),
              onTap: () {
                Navigator.of(context).pop(); // close drawer first
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ActivityHistory(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}