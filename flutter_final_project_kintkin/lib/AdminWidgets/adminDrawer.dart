import 'package:flutter/material.dart';
import 'package:flutter_final_project_kintkin/Pages/CreateCommunity_screen.dart';
import 'package:flutter_final_project_kintkin/Pages/event_screen.dart';
import 'package:flutter_final_project_kintkin/Pages/history_page.dart';
import 'package:flutter_final_project_kintkin/Pages/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Admindrawer extends StatelessWidget {
  const Admindrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color:  Colors.black))
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Menu',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ),
            ListTile(
              leading: const Icon(Icons.history, color: Colors.black),
              title: const Text('Activity History'),
              onTap: (){
                 Navigator.of(context).pop();

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ActivityHistory(),
                  ),
                );
              }
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.group, color: Colors.black),
              title: const Text('Create Community'),
              onTap:() {
                 Navigator.of(context).pop();

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CreatecommunityScreen(),
                  ),
                );
              },
            ),
             const Divider(),
            ListTile(
              leading: const Icon(Icons.edit_calendar, color: Colors.black),
              title: const Text('Create Event'),
              onTap:() {
                 Navigator.of(context).pop();

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CreateEventScreen(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.black),
              title: const Text('Logout'),
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
            )

        ],
      ),
    );
  }
}