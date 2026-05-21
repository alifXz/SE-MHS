// Necessary for ImageFilter.blur
import 'package:flutter/material.dart';
import 'event_card.dart';
import 'basic_card.dart';

class EventCarousel extends StatefulWidget {
  const EventCarousel({super.key});

  @override
  State<EventCarousel> createState() => _EventCarouselState();
}

class _EventCarouselState extends State<EventCarousel> {
  int _currentIndex = 1; // start at center
  late final PageController _pageController;

  final List<EventData> events = [
    EventData(
      title: "Padel Mini Tournament",
      location: "South Jakarta Courts",
      time: "08:00 - 12:00",
      date: "Saturday, 25th July 2026",
      imageUrl: "https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?q=80&w=800",
      type: "COMING SOON",
    ),
    EventData(
      title: "Escape Room",
      location: "Alam Sutera Mall, Alam Sutera",
      time: "10:00 - 15:00",
      date: "Thursday, 23rd July 2026",
      imageUrl: "https://images.unsplash.com/photo-1511512578047-dfb367046420?q=80&w=800",
      type: "POPULAR",
    ),
    EventData(
      title: "Ice Skating Party",
      location: "BX Rink, Bintaro",
      time: "18:00 - 21:00",
      date: "Sunday, 26th July 2026",
      imageUrl: "https://images.unsplash.com/photo-1587463003444-0affd6049f88?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      type: "COMING SOON",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.5, 
      initialPage: _currentIndex,
    );
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
        const SizedBox(height: 12),
        SizedBox(
          height: 320, 
          child: PageView.builder(
            controller: _pageController,
            itemCount: events.length,
            onPageChanged: (i) => setState(() => _currentIndex = i),
            itemBuilder: (context, index) {
              final isCenter = index == _currentIndex;
              return AnimatedScale(
                scale: isCenter ? 1.02 : 0.8,
                duration: const Duration(milliseconds: 300),
                child: EventCard(
                  event: events[index],
                  isCenter: isCenter,
                  onTap: () {
                    // TODO: navigate to EventDetailPage
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}