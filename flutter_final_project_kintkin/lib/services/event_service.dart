import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/event_model.dart';

class EventService {
  final supabase = Supabase.instance.client;

  Future<List<EventModel>> getEvents() async {
    final response = await supabase
        .from('events')
        .select();

    return response
        .map<EventModel>((json) => EventModel.fromJson(json))
        .toList();
  }

  bool isSameDate(DateTime a, DateTime b) {
    return a.year == b.year &&
        a.month == b.month &&
        a.day == b.day;
  }

  Future<List<EventModel>> getUpcomingEvents() async {
    final events = await getEvents();

    final now = DateTime.now();

    return events.where((event) {
      final eventDateTime = DateTime.parse('${event.eventDate} ${event.startTime}');

      return eventDateTime.isAfter(now);
    }).toList();
  }

  Future<List<EventModel>> getPastEvents() async {
    final events = await getEvents();

    final now = DateTime.now();

    return events.where((event) {
      final eventDateTime = DateTime.parse('${event.eventDate} ${event.startTime}');

      return eventDateTime.isBefore(now);
    }).toList();
  }

  Future<List<EventModel>> searchEvents(String query) async {
    final response = await supabase
        .from('events')
        .select()
        .ilike('title', '%$query%');

    final results = response
      .map<EventModel>((json) => EventModel.fromJson(json))
      .toList();

    final now = DateTime.now();
    
    return results.where((event) {
      final eventDate = DateTime.parse(event.eventDate);

      return eventDate.isAfter(now) || isSameDate(eventDate, now);
    }).toList();
  }
}