import 'package:flutter/material.dart';
import 'package:flutter_final_project_kintkin/widgets/activity_carousel.dart';
import '../widgets/TopBar.dart';
import '../widgets/Navbar.dart';
import '../theme/app_colors.dart';
import '../widgets/event_carousel.dart';

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
      
      //Body
      body: SafeArea(
        child: Column(
          children: [
            TopBar(), // Your existing TopBar
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const EventCarousel(),
                    const SizedBox(height: 24),
                    const ActivityCarousel(),
                    
                    // index temp
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Current Section Index: $_currentindex",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),


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