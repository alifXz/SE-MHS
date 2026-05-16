import 'dart:ui'; // Necessary for ImageFilter.blur
import 'package:flutter/material.dart';

// --- Data Model ---
class EventData {
  final String title;
  final String location;
  final String time;
  final String date;
  final String imageUrl;
  final String type;

  EventData({
    required this.title,
    required this.location,
    required this.time,
    required this.date,
    required this.imageUrl,
    required this.type,
  });
}

// --- The Carousel Component ---
class EventCarousel extends StatefulWidget {
  const EventCarousel({super.key});

  @override
  State<EventCarousel> createState() => _EventCarouselState();
}

class _EventCarouselState extends State<EventCarousel> {
  late PageController _pageController;
  double _currentPage = 0.0;

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

  @override
  void initState() {
    super.initState();
    // viewportFraction < 1.0 allows side cards to be visible
    _pageController = PageController(viewportFraction: 0.7, initialPage: 0)
      ..addListener(() {
        setState(() {
          _currentPage = _pageController.page!;
        });
      });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Text(
            'Upcoming Events',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 420,
          child: PageView.builder(
            controller: _pageController,
            itemCount: events.length,
            clipBehavior: Clip.none, // Allows shadows to bleed out
            itemBuilder: (context, index) {
              double relativePosition = index - _currentPage;

              // Scale and Blur calculations
              double scale = (1 - (relativePosition.abs() * 0.2)).clamp(
                0.8,
                1.0,
              );
              double blur = (relativePosition.abs() * 6.0).clamp(0.0, 6.0);
              double opacity = (1 - (relativePosition.abs() * 0.4)).clamp(
                0.4,
                1.0,
              );

              return Transform.scale(
                scale: scale,
                child: Opacity(
                  opacity: opacity,
                  child: Stack(
                    children: [
                      EventCard(event: events[index]),
                      // Blur Overlay for non-centered cards
                      if (blur > 0.1)
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: blur,
                                sigmaY: blur,
                              ),
                              child: Container(color: Colors.transparent),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// --- The Card Component ---
class EventCard extends StatelessWidget {
  final EventData event;
  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Column(
          children: [
            // Image & Badges Section
            Expanded(
              flex: 5,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(event.imageUrl, fit: BoxFit.cover),
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
                  // Category Icon
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
            // Details Section
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
                    const Divider(height: 20, thickness: 1),
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
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
