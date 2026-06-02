import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Pages/history_page.dart';
import '../Pages/event_screen.dart';
import '../pages/login_screen.dart';

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
              leading: const Icon(
                Icons.history,
                color: Colors.black54,
              ),
              title: const Text(
                "Activity History",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                ),
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

            // Events
            ListTile(
              leading: const Icon(
                Icons.event,
                color: Colors.black54,
              ),
              title: const Text(
                "Create Event",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CreateEventScreen(),
                  ),
                );
              },
            ),

            const Divider(height: 1),

            // Logout
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.redAccent,
              ),
              title: const Text(
                "Log Out",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () async {

                Navigator.of(context).pop();

                // Supabase logout
                await Supabase.instance.client.auth.signOut();

                if (context.mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false,
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