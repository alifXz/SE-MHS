import 'package:flutter/material.dart';
import '../widgets/Navbar.dart';
import 'home_screen.dart';
import 'explore_screen.dart'; // Uncomment this when you create it
import 'schedule_screen.dart';
// import 'messages_screen.dart';
// import 'schedule_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // 1. Define your screens here in the exact order of your Navbar items
  final List<Widget> _pages = [
    const HomeScreen(), // We will modify HomeScreen slightly below
    const ExploreScreen(),
    const Center(
      child: Text('Messages Screen', style: TextStyle(color: Colors.white)),
    ),
    const Calendar()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      

      body: IndexedStack(index: _currentIndex, children: _pages),
      
      bottomNavigationBar: Navbar(
        selectedIndex: _currentIndex,
        onTabTapped: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
