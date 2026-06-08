import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EventLeaderboardEntry {
final String eventTitle;
final int participantCount;

EventLeaderboardEntry({required this.eventTitle, required this.participantCount});

factory EventLeaderboardEntry.fromJson(Map<String, dynamic> json) {
return EventLeaderboardEntry(
eventTitle: json['title'] as String,
participantCount: json['participant_count'] as int,
);
}
}

class EventLeaderboardCard extends StatefulWidget {
const EventLeaderboardCard({super.key});

@override
State<EventLeaderboardCard> createState() => _EventLeaderboardCardState();
}

class _EventLeaderboardCardState extends State<EventLeaderboardCard> {
List<EventLeaderboardEntry> _entries = [];
bool _loading = true;

@override
void initState() {
super.initState();
_load();
}

Future<List<EventLeaderboardEntry>> _fetchLeaderboard() async {
final response = await Supabase.instance.client
.from('events')
.select('title, participant_count')
.order('participant_count', ascending: false)
.limit(5);

return (response as List)
.map((e) => EventLeaderboardEntry.fromJson(e as Map<String, dynamic>))
.toList();
}

Future<void> _load() async {
if (mounted) setState(() => _loading = true);
try {
final data = await _fetchLeaderboard();
if (mounted) setState(() { _entries = data; _loading = false; });
} catch (_) {
if (mounted) setState(() { _entries = _mockEntries(); _loading = false; });
}
}

List<EventLeaderboardEntry> _mockEntries() {
return [
EventLeaderboardEntry(eventTitle: 'Event A', participantCount: 120),
EventLeaderboardEntry(eventTitle: 'Event B', participantCount: 95),
EventLeaderboardEntry(eventTitle: 'Event C', participantCount: 80),
EventLeaderboardEntry(eventTitle: 'Event D', participantCount: 60),
EventLeaderboardEntry(eventTitle: 'Event E', participantCount: 45),
];
}

Color _rankColor(int rank) {
if (rank == 1) return const Color(0xFFFFD700);
if (rank == 2) return const Color(0xFFB0BEC5);
if (rank == 3) return const Color(0xFFCD7F32);
return Colors.white38;
}

@override
Widget build(BuildContext context) {
return Container(
width: double.infinity,
padding: const EdgeInsets.all(40),
decoration: BoxDecoration(
color: const Color(0xFF333230),
borderRadius: BorderRadius.circular(35),
boxShadow: const [
BoxShadow(
color: Colors.black12,
blurRadius: 15,
offset: Offset(0, 6),
),
],
),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
const Text(
'Top Events',
style: TextStyle(
color: Colors.white70,
fontSize: 15,
fontWeight: FontWeight.w600,
),
),
GestureDetector(
onTap: _load,
child: const Icon(Icons.refresh, color: Colors.white30, size: 16),
),
],
),
const SizedBox(height: 22),
if (_loading)
const Center(
child: Padding(
padding: EdgeInsets.symmetric(vertical: 12),
child: CircularProgressIndicator(
color: Color(0xFFEAD8A7),
strokeWidth: 2,
),
),
)
else
...List.generate(_entries.length, (i) {
final entry = _entries[i];
final rank = i + 1;
return Padding(
padding: EdgeInsets.only(bottom: i < _entries.length - 1 ? 16 : 0),
child: Row(
children: [
SizedBox(
width: 30,
child: Text(
'#$rank',
style: TextStyle(
color: _rankColor(rank),
fontSize: 15,
fontWeight: FontWeight.bold,
),
),
),
const SizedBox(width: 10),
Expanded(
child: Text(
entry.eventTitle,
style: const TextStyle(
color: Colors.white,
fontSize: 14,
fontWeight: FontWeight.w500,
),
overflow: TextOverflow.ellipsis,
),
),
Row(
children: [
const Icon(Icons.people, color: Colors.white38, size: 14),
const SizedBox(width: 5),
Text(
'${entry.participantCount}',
style: const TextStyle(
color: Colors.white54,
fontSize: 14,
fontWeight: FontWeight.w600,
),
),
],
),
],
),
);
}),
],
),
);
}
}
