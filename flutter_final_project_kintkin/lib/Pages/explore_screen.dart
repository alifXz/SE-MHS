import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/explore_card.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  bool isEventsSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 15),
              child: Row(
                children: [
                  const Text(
                    "Find Your Event/Community!",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none, color: Colors.black),
                  ),
                 Builder(
                    builder: (context) => IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: const Icon(Icons.menu, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      body: Column(
        children: [

          // --- TAB TOGGLE SECTION ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      children: [
                        // Events Tab
                        Expanded(
                          child: _buildToggleButton(
                            "Events",
                            isEventsSelected,
                            () => setState(() => isEventsSelected = true),
                            const Color(0xFF801A1A), // red
                          ),
                        ),
                        // Communities Tab
                        Expanded(
                          child: _buildToggleButton(
                            "Communities",          
                            !isEventsSelected,      
                            () => setState(() => isEventsSelected = false), 
                            const Color(0xFF003049), 
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                // Filter Icon
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.tune, size: 20),
                ),
              ],
            ),
          ),
          
          // --- DYNAMIC LIST SECTION ---
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: 3,
              itemBuilder: (context, index) {
                return ExploreCard(isCommunity: !isEventsSelected);
              },
            ),
          ),
        ],
      ),
      
    );
  }

  Widget _buildToggleButton(String label, bool active, VoidCallback onTap, Color activeColor) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: active ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}