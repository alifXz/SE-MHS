import 'package:flutter/material.dart';
import 'basic_card.dart';

class EventCard extends StatelessWidget {
  final EventData event;
  final bool isCenter;
  final VoidCallback? onTap;

  static const double cardWidth = 230;
  static const double cardHeight = 260;
  static const double imageHeight = 160;

  const EventCard({
    super.key,
    required this.event,
    this.isCenter = false,
    this.onTap,
  });

@override
Widget build(BuildContext context) {
  return GestureDetector(
    onTap: onTap,
    child: Center(  // ← centers the card in its page slot
      child: Container(
        width: cardWidth,   // ← width goes here, not on SizedBox
        height: cardHeight,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: isCenter
              ? [BoxShadow(color: Colors.orange.withOpacity(0.4), blurRadius: 30, spreadRadius: 5)]
              : [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(),
              _buildDetails(),
            ],
          ),
        ),
      ),
    ),
  );
}

  Widget _buildImage() {
    return Stack(
      children: [
        SizedBox(
          height: imageHeight,
          width: double.infinity,
          child: Image.network(
            event.imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Container(color: Colors.grey[200]);
            },
          ),
        ),
        // Tag badge
        Positioned(
          top: 12,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: event.type == 'POPULAR'
                  ? const Color(0xFF801A1A)
                  : const Color(0xFFD81B60),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  event.type,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 3),
                const Icon(Icons.local_fire_department, color: Colors.white, size: 11),
              ],
            ),
          ),
        ),
        // Category icon
        Positioned(
          top: 12,
          right: 12,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Color(0xFFFFD700),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.directions_run, size: 16, color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget _buildDetails() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              event.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Divider(height: 10),
            _infoRow(Icons.location_on_outlined, event.location),
            const SizedBox(height: 3),
            _infoRow(Icons.access_time_outlined, event.time),
            const SizedBox(height: 3),
            _infoRow(Icons.calendar_month_outlined, event.date),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 11, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}