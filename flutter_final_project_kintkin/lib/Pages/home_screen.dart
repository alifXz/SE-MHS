import 'package:flutter/material.dart';
import 'package:flutter_final_project_kintkin/widgets/activity_carousel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../widgets/TopBar.dart';
import '../widgets/app_drawer.dart';
import '../widgets/event_carousel.dart';

class HomeScreen extends StatefulWidget {
  final bool isNewRegistration;

  const HomeScreen({
    super.key,
    this.isNewRegistration = false,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final User? _currentUser = Supabase.instance.client.auth.currentUser;

  String _userName = "Guest";

  @override
  void initState() {
    super.initState();

    // Registration success snackbar
    if (widget.isNewRegistration && _currentUser != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Account successfully registered: ${_currentUser!.email}',
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 4),
          ),
        );
      });
    }

    _loadProfileName();
  }

  Future<void> _loadProfileName() async {
    if (_currentUser == null) return;

    try {
      final response = await Supabase.instance.client
        .from('users')
        .select('name')
        .eq('id', _currentUser!.id)
        .single();

      if (mounted) {
        setState(() {
          _userName = response['name'] ?? 'Guest';
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: Column(
        children: [
          TopBar(userName: _userName),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  EventCarousel(),
                  SizedBox(height: 32),
                  ActivityCarousel(),
                  SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}