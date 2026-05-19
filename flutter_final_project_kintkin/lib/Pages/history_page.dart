import 'package:flutter/material.dart';
import 'package:flutter_final_project_kintkin/widgets/app_drawer.dart';
import '../widgets/basic_card.dart';

class ActivityHistory extends StatefulWidget {
  const ActivityHistory({super.key});

  @override
  State<ActivityHistory> createState() => _ActiviryHistoryState();
}

class _ActiviryHistoryState extends State<ActivityHistory> {
  final List<EventData> _history = [
    EventData(
      title: 'Morning Run', 
      location: 'SCBD', 
      time: '05:00 - 10:00', 
      date: '18 May 2026 ', 
      imageUrl: "", 
      type: 'Sports',
      ),
  
   
    EventData( 
     title: 'Padel', 
     location: 'Padelton',
     time: '16:00 - 18:00', 
     date: '19 May 2026', 
     imageUrl: "", 
     type: 'Sports',
     ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: PreferredSize(preferredSize: const Size.fromHeight(70), 
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 15),
          child: Row(
            children: [
              const Text(
                
                  "Activity History",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
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
      body: _history.isEmpty
          ? const Center(
              child: Text(
                'No Past Activities Found',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              itemCount: _history.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: SizedBox(
                  height: 280, // Matches the explicit layout size from schedule_screen.dart
                  child: BasicCard(event: _history[index]),
                ),
              ),
          ),
    );
  }
}