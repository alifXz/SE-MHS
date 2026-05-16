import 'package:flutter/material.dart';

class RecentActivities extends StatelessWidget {
  const RecentActivities({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> activities = [
      {
        'title': 'Joined "Padel Tournament"',
        'time': '2 hours ago',
        'icon': '🎾',
      },
      {
        'title': 'Shared "Escape Room" event',
        'time': '5 hours ago',
        'icon': '🧩',
      },
      {
        'title': 'Followed "South Jakarta Courts"',
        'time': 'Yesterday',
        'icon': '📍',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Text(
            'Recent Activities',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true, // Necessary because it's inside a ScrollView/Column
          physics: const NeverScrollableScrollPhysics(),
          itemCount: activities.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue[50],
                  child: Text(activities[index]['icon']!),
                ),
                title: Text(
                  activities[index]['title']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                subtitle: Text(
                  activities[index]['time']!,
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
                trailing: const Icon(Icons.chevron_right, size: 20),
              ),
            );
          },
        ),
      ],
    );
  }
}
