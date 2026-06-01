import 'package:flutter/material.dart';
import 'event_card.dart';

import '../services/event_service.dart';
import '../models/event_model.dart';

class EventCarousel extends StatefulWidget {
  const EventCarousel({super.key});

  @override
  State<EventCarousel> createState() => _EventCarouselState();
}

class _EventCarouselState extends State<EventCarousel> {
  List<EventModel> events = [];
  bool _loading = true;

  final PageController _pageController = PageController(viewportFraction: 0.45);
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    loadEvents();
  }

  Future<void> loadEvents() async {
    final result = await EventService().getUpcomingEvents();

    if(!mounted) return;

    setState(() {
      events = result.take(3).toList();
      _loading = false;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(!_loading && events.isEmpty) {
      return const Center(
        child: Text('No events available'),
      );
    }

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
          child: _loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : PageView.builder(
                controller: _pageController,
                itemCount: events.length,
                onPageChanged: (i) =>
                  setState(() => _currentIndex = i),
                itemBuilder: (context, index) {
                  final isCenter = index == _currentIndex;

                  return AnimatedScale(
                    scale: isCenter ? 1.0 : 0.8,
                    duration: const Duration(milliseconds: 300),
                    child: EventCard(
                      event: events[index],
                      isCenter: isCenter,
                      onTap: () {},
                    ),
                  );
                },
              ),
        ),
      ],
    );
  }
}