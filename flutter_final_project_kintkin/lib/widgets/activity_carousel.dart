// import 'package:flutter/material.dart';
// import 'basic_card.dart';

// class ActivityCarousel extends StatefulWidget {
//   const ActivityCarousel({super.key});

//   @override
//   State<ActivityCarousel> createState() => _ActivityCarouselState();
// }

// class _ActivityCarouselState extends State<ActivityCarousel> {
//   int _currentIndex = 0;
//   late final PageController _pageController;

//   final List<EventData> events = [
//     EventData(
//       title: "Escape Room",
//       location: "Alam Sutera Mall, Alam Sutera",
//       startTime: "08:00",
//       endTime: "12:00",
//       eventDate: "Thursday, 23rd July 2026",
//       imageUrl: "https://images.unsplash.com/photo-1511512578047-dfb367046420?q=80&w=800",
//       type: "POPULAR",
//     ),
//     EventData(
//       title: "Padel Mini Tournament",
//       location: "South Jakarta Courts",
//       startTime: "08:00",
//       endTime: "12:00",
//       eventDate: "Saturday, 25th July 2026",
//       imageUrl: "https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?q=80&w=800",
//       type: "COMING SOON",
//     ),
//     EventData(
//       title: "Ice Skating Party",
//       location: "BX Rink, Bintaro",
//       startTime: "08:00",
//       endTime: "12:00",
//       eventDate: "Sunday, 26th July 2026",
//       imageUrl: "https://images.unsplash.com/photo-1587463003444-0affd6049f88?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
//       type: "COMING SOON",
//     ),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(
//       viewportFraction: 0.78,
//       initialPage: _currentIndex,
//     );
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 24),
//           child: Text(
//             'Recent Activities :',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         const SizedBox(height: 5),
//         SizedBox(
//           height: 275,
//           child: PageView.builder(
//             controller: _pageController,
//             itemCount: events.length,
//             onPageChanged: (i) => setState(() => _currentIndex = i),
//             itemBuilder: (context, index) {
//               final isCenter = index == _currentIndex;
//               return AnimatedScale(
//                 scale: isCenter ? 1.0 : 1.0,
//                 duration: const Duration(milliseconds: 300),
//                 child: BasicCard(
//                   event: events[index],
//                   onTap: () {
//                     // TODO: navigate to ActivityHistoryPage
//                   },
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }