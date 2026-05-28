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
      startTime: "08:00",
      endTime: "12:00",
      eventDate: '18 May 2026 ',
      imageUrl: "https://images.unsplash.com/flagged/photo-1556746834-cbb4a38ee593?q=80&w=2072&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      type: 'Sports',
    ),
    EventData(
      title: 'Padel',
      location: 'Padelton',
      startTime: "08:00",
      endTime: "12:00",
      eventDate: '19 May 2026',
      imageUrl: "https://images.unsplash.com/photo-1646649853703-7645147474ba?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      type: 'Sports',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 15),
            child: Row(
              children: [
                // Back button
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 16),
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
                  height: 280,
                  child: BasicCard(event: _history[index]),
                ),
              ),
            ),
    );
  }
}