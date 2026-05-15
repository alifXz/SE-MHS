import 'package:flutter/material.dart';
import 'basic_card.dart';

class ActivityCarousel extends StatefulWidget {
  const ActivityCarousel({super.key});

  @override
  State<ActivityCarousel> createState() => _ActivityCarouselState();
}

class _ActivityCarouselState extends State<ActivityCarousel> {
  int _currentIndex = 0;
  late final PageController _pageController;

  final List<EventData> events = [
    EventData(
      title: "Escape Room",
      location: "Alam Sutera Mall, Alam Sutera",
      time: "10:00 - 15:00",
      date: "Thursday, 23rd July 2026",
      imageUrl: "https://images.unsplash.com/photo-1511512578047-dfb367046420?q=80&w=800",
      type: "POPULAR",
    ),
    EventData(
      title: "Padel Mini Tournament",
      location: "South Jakarta Courts",
      time: "08:00 - 12:00",
      date: "Saturday, 25th July 2026",
      imageUrl: "https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?q=80&w=800",
      type: "COMING SOON",
    ),
    EventData(
      title: "Ice Skating Party",
      location: "BX Rink, Bintaro",
      time: "18:00 - 21:00",
      date: "Sunday, 26th July 2026",
      imageUrl: "https://images.unsplash.com/photo-1547113110-39f7a7837078?q=80&w=800",
      type: "COMING SOON",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.78,
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
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Recent Activities :',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 275,
          child: PageView.builder(
            controller: _pageController,
            itemCount: events.length,
            onPageChanged: (i) => setState(() => _currentIndex = i),
            itemBuilder: (context, index) {
              final isCenter = index == _currentIndex;
              return AnimatedScale(
                scale: isCenter ? 1.0 : 0.9,
                duration: const Duration(milliseconds: 300),
                child: BasicCard(
                  event: events[index],
                  onTap: () {
                    // TODO: navigate to ActivityHistoryPage
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