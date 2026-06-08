import 'package:flutter/material.dart';
import 'package:flutter_final_project_kintkin/models/event_model.dart';
import 'package:flutter_final_project_kintkin/services/event_service.dart';
import 'package:flutter_final_project_kintkin/AdminWidgets/admin_event_card.dart';
import 'event_screen.dart';

class AdminEventsPage extends StatefulWidget {
const AdminEventsPage({super.key});

@override
State<AdminEventsPage> createState() => _AdminEventsPageState();
}

class _AdminEventsPageState extends State<AdminEventsPage> {
List<EventModel> _events = [];
bool _loading = true;

@override
void initState() {
super.initState();
_loadEvents();
}

Future<void> _loadEvents() async {
if (mounted) setState(() => _loading = true);
final events = await EventService().getEvents();
if (!mounted) return;
setState(() {
_events = events;
_loading = false;
});
}

Future<void> _deleteEvent(EventModel event) async {
setState(() => _events.removeWhere((e) => e.id == event.id));
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
'Manage Events',
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
floatingActionButton: FloatingActionButton(
onPressed: () async {
await Navigator.of(context).push(
MaterialPageRoute(builder: (_) => const CreateEventScreen()),
);
_loadEvents();
},
backgroundColor: const Color(0xFF333230),
child: const Icon(Icons.add, color: Colors.white),
),
body: _loading
? const Center(child: CircularProgressIndicator())
: _events.isEmpty
? const Center(
child: Text(
'No Events Found',
style: TextStyle(color: Colors.grey, fontSize: 16),
),
)
: ListView.builder(
padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
itemCount: _events.length,
itemBuilder: (context, index) => Padding(
padding: const EdgeInsets.only(bottom: 16),
child: AdminEventCard(
event: _events[index],
onDelete: () => _deleteEvent(_events[index]),
),
),
),
);
}
}
