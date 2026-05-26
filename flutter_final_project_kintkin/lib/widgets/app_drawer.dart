import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Pages/history_page.dart';
import '../pages/login_screen.dart'; // Verify this path matches your file structure
import '../Pages/event_screen.dart';
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
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 24, 20, 24),
              child: Text(
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
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ActivityHistory(),
                  ),
                );
              },
            ),
            const Divider(height: 1),

            // 2. ADD YOUR NEW EVENT NAVIGATION TILE HERE
            ListTile(
              leading: const Icon(Icons.event, color: Colors.black54),
              title: const Text(
                "Events", // Change this text to whatever you want it to say in the menu
                style: TextStyle(fontSize: 15, color: Colors.black87),
              ),
              onTap: () {
                Navigator.of(context).pop(); // Closes the drawer first
                Navigator.of(context).push(
                  MaterialPageRoute(
                    // Make sure 'EventScreen' matches the exact class name in your event_screen.dart file
                    builder: (context) => const CreateEventScreen(), 
                  ),
                );
              },
            ),

            

            const Divider(height: 1), // Optional clean separation line
            // Log Out (Right after History)
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text(
                "Log Out",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () async {
                Navigator.of(context).pop(); // Close drawer

                await FirebaseAuth.instance.signOut(); // Log out

                if (context.mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false, // Clear history stack
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
