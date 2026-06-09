import 'package:flutter/material.dart';
import 'package:flutter_final_project_kintkin/Pages/edit_event_page.dart';
import 'package:flutter_final_project_kintkin/models/event_model.dart';
import 'package:flutter_final_project_kintkin/services/event_service.dart';
import 'package:flutter_final_project_kintkin/widgets/basic_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ActiveEventsPage extends StatefulWidget {
  const ActiveEventsPage({super.key});

  @override
  State<ActiveEventsPage> createState() => _ActiveEventsPageState();
}

class _ActiveEventsPageState extends State<ActiveEventsPage> {
  List<EventModel> _events = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    if (mounted) setState(() => _loading = true);
    final events = await EventService().getUpcomingEvents();
    if (!mounted) return;
    setState(() {
      _events = events;
      _loading = false;
    });
  }

  Future<void> _deleteEvent(EventModel event) async {
    try {
      await Supabase.instance.client
          .from('events')
          .delete()
          .eq('id', event.id);

      setState(() => _events.removeWhere((e) => e.id == event.id));

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${event.title} deleted')),
      );
    } catch (e) {
      debugPrint('Error deleting event: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete event')),
      );
    }
  }

  void _confirmDelete(EventModel event) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete Event'),
        content: Text('Are you sure you want to delete "${event.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _deleteEvent(event);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Color(0xFF801A1A)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _editEvent(EventModel event) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EditEventPage(
          event: {
            'id': event.id,
            'title': event.title,
            'description': event.description,
            'location': event.location,
            'location_link': event.locationLink,
            'start_time': event.startTime,
            'end_time': event.endTime,
            'event_date': event.eventDate,
            'organizer': event.organizer,
            'image_url': event.imageUrl,
            'venue_partner': event.venuePartner,
            'price': event.price,
            'category': event.category,
          },
        ),
      ),
    );
    if (result == true) _loadEvents();
  }

  void _showActionSheet(EventModel event) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              event.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.edit, color: Color(0xFF1B4F6B)),
              title: const Text('Edit Event'),
              onTap: () {
                Navigator.pop(ctx);
                _editEvent(event);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Color(0xFF801A1A)),
              title: const Text(
                'Delete Event',
                style: TextStyle(color: Color(0xFF801A1A)),
              ),
              onTap: () {
                Navigator.pop(ctx);
                _confirmDelete(event);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 15),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 16),
                const Text(
                  'Active Events',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _events.isEmpty
              ? const Center(
                  child: Text(
                    'No Active Events Found',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  itemCount: _events.length,
                  itemBuilder: (context, index) {
                    final event = _events[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SizedBox(
                        height: 280,
                        child: BasicCard(
                          event: event,
                          onTap: () => _showActionSheet(event),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}