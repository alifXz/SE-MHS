import 'package:flutter/material.dart';
import '../models/event_model.dart';

class AdminEventCard extends StatelessWidget {
  final EventModel event;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const AdminEventCard({
    super.key,
    required this.event,
    this.onDelete,
    this.onEdit,
  });

  Color _categoryColor() {
    switch (event.category.toLowerCase()) {
      case 'sports':
        return const Color(0xFF801A1A);
      case 'gaming':
        return Colors.purple;
      case 'music':
        return Colors.orange;
      case 'group activity':
        return Colors.blue;
      case 'others':
        return Colors.green;
      default:
        return const Color(0xFFD81B60);
    }
  }

  IconData _categoryIcon() {
    switch (event.category.toLowerCase()) {
      case 'sports':
        return Icons.directions_run;
      case 'gaming':
        return Icons.sports_esports;
      case 'music':
        return Icons.music_note;
      case 'group activity':
        return Icons.groups;
      case 'others':
        return Icons.event;
      default:
        return Icons.event;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
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
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return SizedBox(
      height: 160,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(event.imageUrl, fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.2),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Positioned(
            top: 15,
            left: 15,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _categoryColor(),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                event.category.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            top: 15,
            right: 15,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Color(0xFFFFD700),
                shape: BoxShape.circle,
              ),
              child: Icon(_categoryIcon(), size: 20, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetails() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 12, 22, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Divider(height: 0.2, color: Colors.grey),
          const SizedBox(height: 8),
          _infoRow(Icons.location_on_outlined, event.location),
          const SizedBox(height: 3),
          _infoRow(
            Icons.access_time_outlined,
            '${event.startTime.substring(0, 5)} - ${event.endTime.substring(0, 5)}',
          ),
          const SizedBox(height: 3),
          _infoRow(Icons.calendar_month_outlined, event.eventDate),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: onEdit,
            icon: const Icon(Icons.edit_outlined, color: Color(0xFF1B4F6B)),
            tooltip: 'Edit event',
          ),
          IconButton(
            onPressed: () => _confirmDelete(context),
            icon: const Icon(Icons.delete_outline, color: Color(0xFF801A1A)),
            tooltip: 'Delete event',
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete Event'),
        content: Text('Are you sure you want to delete "${event.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Delete',
              style: TextStyle(color: Color(0xFF801A1A)),
            ),
          ),
        ],
      ),
    );
    if (confirmed == true && onDelete != null) onDelete!();
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
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
