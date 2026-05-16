import 'package:flutter/material.dart';
import 'package:flutter_final_project_kintkin/widgets/activity_carousel.dart';
import '../widgets/TopBar.dart';
import '../widgets/event_carousel.dart';

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          TopBar(),
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
    );
  }
}
