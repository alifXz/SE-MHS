import 'package:flutter/material.dart';

// Data model for the events
class EventData {
  final String title;
  final String location;
  final String time;
  final String date;
  final String imageUrl;
  final String type; // 'POPULAR' or 'COMING SOON'

  EventData({
    required this.title,
    required this.location,
    required this.time,
    required this.date,
    required this.imageUrl,
    required this.type,
  });
}

class EventCarousel extends StatelessWidget {
  const EventCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data to match your requested pictures
    final List<EventData> events = [
      EventData(
        title: "Escape Room",
        location: "Alam Sutera Mall, Alam Sutera",
        time: "10:00 - 15:00",
        date: "Thursday, 23rd July 2026",
        imageUrl:
            "https://images.unsplash.com/photo-1511512578047-dfb367046420?q=80&w=800",
        type: "POPULAR",
      ),
      EventData(
        title: "Padel Mini Tournament",
        location: "South Jakarta Courts",
        time: "08:00 - 12:00",
        date: "Saturday, 25th July 2026",
        imageUrl:
            "https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?q=80&w=800",
        type: "COMING SOON",
      ),
      EventData(
        title: "Ice Skating Party",
        location: "BX Rink, Bintaro",
        time: "18:00 - 21:00",
        date: "Sunday, 26th July 2026",
        imageUrl:
            "https://images.unsplash.com/photo-1547113110-39f7a7837078?q=80&w=800",
        type: "COMING SOON",
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Upcoming Events :',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 380, // Height for the carousel cards
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: events.length,
            itemBuilder: (context, index) {
              return EventCard(event: events[index]);
            },
          ),
        ),
      ],
    );
  }
}

class EventCard extends StatelessWidget {
  final EventData event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(
          0xFFF0F0F0,
        ), // Matching the light grey background in photo
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Column(
          children: [
            // Image Section with Badges
            Expanded(
              flex: 5,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(event.imageUrl, fit: BoxFit.cover),
                  // Dark gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.2),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  // "POPULAR" Badge
                  Positioned(
                    top: 15,
                    left: 15,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: event.type == 'POPULAR'
                            ? const Color(0xFF801A1A)
                            : const Color(0xFFD81B60),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Text(
                            event.type,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.local_fire_department,
                            color: Colors.white,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Running Icon
                  Positioned(
                    top: 15,
                    right: 15,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFD700),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.directions_run,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Info Content Section
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(height: 1, color: Colors.grey),
                    const SizedBox(height: 12),
                    _infoRow(Icons.location_on_outlined, event.location),
                    const SizedBox(height: 8),
                    _infoRow(Icons.access_time_outlined, event.time),
                    const SizedBox(height: 8),
                    _infoRow(Icons.calendar_month_outlined, event.date),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
