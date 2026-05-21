import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_final_project_kintkin/widgets/activity_carousel.dart';
import '../services/auth_service.dart'; // Import your service layer!
import '../widgets/TopBar.dart';
import '../widgets/app_drawer.dart';
import '../widgets/event_carousel.dart';


class HomeScreen extends StatefulWidget {
  final bool isNewRegistration; // Add this line
  const HomeScreen({super.key, this.isNewRegistration = false});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService(); // Instantiate service
  final User? _currentUser = FirebaseAuth.instance.currentUser;
  String _userName = "Guest";

  @override
  void initState() {
    super.initState();

    // 1. Success Message
// ONLY show the snackbar if explicitly told they just registered!
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
    drawer: const AppDrawer(),
    body: Column(
      children: [
        TopBar(userName: _userName),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const EventCarousel(),
                const SizedBox(height: 32),
                const ActivityCarousel(),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
}
