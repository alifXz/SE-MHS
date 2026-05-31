import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../widgets/app_drawer.dart';
import '../widgets/basic_card.dart';

import '../models/event_model.dart';
import '../services/event_service.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar>{
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List <EventModel> _allEvents = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    final events = await EventService().getEvents();

    if (!mounted) return;

    setState(() {
      _allEvents = events;
      _loading = false;
    });
  }

  List<EventModel> _getEventsForDay(DateTime day) {
    return _allEvents.where((event) {
      final eventDate = DateTime.parse(event.eventDate);

      return eventDate.year == day.year &&
          eventDate.month == day.month &&
          eventDate.day == day.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final day = _selectedDay ?? _focusedDay;
    final events = _getEventsForDay(day);

    return Scaffold(
    drawer: const AppDrawer(),
     appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 15),
              child: Row(
                children: [
                  const Text(
                    "Schedule",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none, color: Colors.black),
                  ),
                  Builder(
                    builder: (context) => IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: const Icon(Icons.menu, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      body: Column(
       children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2025, 1, 1),
            lastDay: DateTime(2030, 12, 31),

            eventLoader: _getEventsForDay,

            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, day, events) {
                if (events.isEmpty) return null;

                return Positioned(
                  bottom: -2,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            ),

            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),

          Expanded(
            child: _loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : events.isEmpty
                  ? const Center(
                      child: Text('No activities planned'),
                    )
                  : ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) => SizedBox(
                      height: 280,
                      child: BasicCard(event: events[index]),
                    ),
                  ),
            ),
        ],
      ),
    );
  }
}