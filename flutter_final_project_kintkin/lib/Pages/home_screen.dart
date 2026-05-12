import 'package:flutter/material.dart';
import '../widgets/TopBar.dart';
import '../widgets/Navbar.dart';
import '../theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // Match the NavBar background!
      
      // 1. The Body
      body: SafeArea(
        child: Column(
          children: [
            TopBar(), // Your existing TopBar
            Expanded(
              child: Center(
                child: Text("Page Index: $_currentindex", style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
            ),
          ],
        ),
      ),

      // 2. The Bottom NavBar (using your new widget function)
      bottomNavigationBar: Navbar(
        selectedIndex: _currentindex,
        onTabTapped: (index) {
          setState(() {
            _currentindex = index;
          });
        },
      ),
    );
  }
}