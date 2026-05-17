import 'package:flutter/material.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import '../theme/app_colors.dart';

class Navbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabTapped;
  final GlobalKey<CurvedNavigationBarState>? navKey;

  const Navbar({
    super.key,
    required this.selectedIndex,
    required this.onTabTapped,
    this.navKey,
  });

  Color iconColor(int index) =>
      selectedIndex == index ? Colors.white : Colors.black;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      key: navKey,
      index: selectedIndex,
      items: [
        CurvedNavigationBarItem(
          child: Icon(Icons.home_outlined, color: iconColor(0)),
          label: 'Home',
        ),
        CurvedNavigationBarItem(
          child: Icon(Icons.explore, color: iconColor(1)),
          label: 'Explore',
        ),
        CurvedNavigationBarItem(
          child: Icon(Icons.chat_bubble_outline, color: iconColor(2)),
          label: 'Messages',
        ),
        CurvedNavigationBarItem(
          child: Icon(Icons.calendar_month, color: iconColor(3)),
          label: 'Schedule',
        ),
      ],

      
      color: AppColors.navBarbg,
      buttonBackgroundColor: AppColors.selectedNav,
      backgroundColor: Colors.transparent,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      onTap: onTabTapped,
    );
  }
}