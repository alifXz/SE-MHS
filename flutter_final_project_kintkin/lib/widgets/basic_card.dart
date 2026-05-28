import 'package:flutter/material.dart';

class EventData {
  final String title;
  final String location;
  final String startTime;
  final String endTime;
  final String eventDate;
  final String imageUrl;
  final String type;

  EventData({
    required this.title,
    required this.location,
    required this.startTime,
    required this.endTime,
    required this.eventDate,
    required this.imageUrl,
    required this.type,
  });
}

class BasicCard extends StatelessWidget {
  final EventData event;
  final VoidCallback? onTap;

  const BasicCard({
    super.key,
    required this.event,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: Column(
            children: [
              _buildImage(),
              _buildDetails(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Expanded(
      flex: 5,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(event.imageUrl, fit: BoxFit.cover),
          // Gradient overlay
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
          // Type badge
          Positioned(
            top: 15,
            left: 15,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                  const Icon(Icons.local_fire_department, color: Colors.white, size: 14),
                ],
              ),
            ),
          ),
          // Category icon
          Positioned(
            top: 15,
            right: 15,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Color(0xFFFFD700),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.directions_run, size: 20, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetails() {
    return Expanded(
      flex: 4,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 3),
            const Divider(height: 0.2, color: Colors.grey),
            const SizedBox(height: 8),
            _infoRow(Icons.location_on_outlined, event.location),
            const SizedBox(height: 3),
            _infoRow(Icons.access_time_outlined, "${event.startTime} - ${event.endTime}"),
            const SizedBox(height: 3),
            _infoRow(Icons.calendar_month_outlined, event.eventDate),
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