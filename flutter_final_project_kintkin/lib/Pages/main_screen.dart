import 'package:flutter/material.dart';
import '../widgets/Navbar.dart';
import 'home_screen.dart';
import 'explore_screen.dart'; 
import 'schedule_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;


 @override
  Widget build(BuildContext context) {
  final List<Widget> _pages = [   
    const HomeScreen(), 
    const ExploreScreen(),
    const Calendar(),
  ];

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
