import 'package:flutter/material.dart';
import '../widgets/Navbar.dart';
import 'home_screen.dart';
import 'explore_screen.dart'; 
import 'schedule_screen.dart';


class MainScreen extends StatefulWidget {
  final bool isNewRegistration; // For the "successfully registered" snackbar

  const MainScreen({
    super.key,
    this.isNewRegistration = false,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;


 @override
  Widget build(BuildContext context) {
  final List<Widget> pages = [   
    HomeScreen(isNewRegistration: widget.isNewRegistration),
    const ExploreScreen(),
    const Calendar(),
  ];

  return Scaffold(
    body: IndexedStack(index: _currentIndex, children: pages),
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
