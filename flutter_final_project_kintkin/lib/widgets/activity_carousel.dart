import 'package:flutter/material.dart';
import 'package:flutter_final_project_kintkin/models/event_model.dart';
import 'package:flutter_final_project_kintkin/services/event_service.dart';
import 'package:flutter_final_project_kintkin/Pages/history_page.dart';

import 'basic_card.dart';

class ActivityCarousel extends StatefulWidget {
  const ActivityCarousel({super.key});

  @override
  State<ActivityCarousel> createState() => _ActivityCarouselState();
}

class _ActivityCarouselState extends State<ActivityCarousel> {
  int _currentIndex = 0;
  late final PageController _pageController;

  List<EventModel> _recentActivities = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.78,
      initialPage: _currentIndex,
    );

    loadHistory();
  }

  Future<void> loadHistory() async {
    final result = await EventService().getUserHistory();

    if (!mounted) return;

    result.sort(
      (a, b) => DateTime.parse(b.eventDate)
        .compareTo(DateTime.parse(a.eventDate)),
    );

    setState(() {
      _recentActivities = result.take(3).toList();
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
          child: _loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _recentActivities.isEmpty
              ? const Center(
                  child: Text(
                    'No Recent Activities',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  )
                )
              : PageView.builder(
                  controller: _pageController,
                  itemCount: _recentActivities.length,
                  onPageChanged: (i) => setState(() => _currentIndex = i),
                  itemBuilder: (context, index) {
                    final isCenter = index == _currentIndex;
                    return AnimatedScale(
                      scale: isCenter ? 1.0 : 1.0,
                      duration: const Duration(milliseconds: 300),
                      child: BasicCard(
                        event: _recentActivities[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ActivityHistory(),
                            )
                          );
                        },
                      ),
                    );
                  },
                )
        ),
      ],
    );
  }
}