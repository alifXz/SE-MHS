import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../widgets/app_drawer.dart';
import '../widgets/basic_card.dart';
class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar>{
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<DateTime, List<EventData>> _events = {
    DateTime.utc(2026,5,18):[
      EventData(
      title: 'Morning Run', 
      location: 'SCBD', 
      time: '05:00 - 10:00', 
      date: '18 May 2026 ', 
      imageUrl: "", 
      type: 'Sports',
      ),
     
    ],

    DateTime.utc(2026,5,18):[
    EventData( 
     title: 'Padel', 
     location: 'Padelton',
     time: '16:00 - 18:00', 
     date: '19 May 2026', 
     imageUrl: "", 
     type: 'Sports',
     ),
    ],
  };


  @override
  Widget build(BuildContext context) {
    final day = _selectedDay ?? _focusedDay;
    final key = DateTime.utc(day.year, day.month, day.day);
    final events = _events[key] ?? [];
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
                      fontSize: 18,
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
            firstDay: DateTime.utc(2026, 1, 1),
            lastDay: DateTime(2026, 12, 31),
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
            child: events.isEmpty
                ? Center(child: Text('No Activities Planned'))
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