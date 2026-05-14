import 'package:flutter/material.dart';
import 'package:flutter_final_project_kintkin/widgets/event_carousel.dart';
import '../widgets/TopBar.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Isi dari pagenya
              TopBar(),
              const EventCarousel(),
            ],
          ),
        )
      ),
    );
  }
}