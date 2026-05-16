import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_final_project_kintkin/widgets/activity_carousel.dart';
import '../services/auth_service.dart'; // Import your service layer!
import '../widgets/TopBar.dart';
import '../widgets/event_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService(); // Instantiate service
  final User? _currentUser = FirebaseAuth.instance.currentUser;
  String _userName = "Loading...";

  @override
  void initState() {
    super.initState();

    // 1. Success Message
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_currentUser != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Account successfully registered: ${_currentUser.email}',
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    });

    // 2. Fetch data via Service
    _loadProfileName();
  }

  Future<void> _loadProfileName() async {
    if (_currentUser == null) return;

    // Ask the service layer to do the heavy lifting
    String name = await _authService.getUserName(_currentUser.uid);

    if (mounted) {
      setState(() => _userName = name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            TopBar(userName: _userName),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const EventCarousel(),
                    const SizedBox(height: 24),
                    const ActivityCarousel(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
