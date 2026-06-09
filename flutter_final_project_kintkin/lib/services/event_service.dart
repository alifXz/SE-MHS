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

  Future<List<EventModel>> getUserHistory() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;

    if (userId == null) return [];

    final regResponse = await Supabase.instance.client
        .from('registrations')
        .select('event_id')
        .eq('user_id', userId);

    if (regResponse.isEmpty) return [];

    final eventIds = regResponse
        .map((row) => row['event_id'] as String)
        .toList();

    final eventResponse = await Supabase.instance.client
        .from('events')
        .select()
        .inFilter('id', eventIds)
        .lt('event_date', DateTime.now().toIso8601String());

    return eventResponse
        .map((row) => EventModel.fromJson(row))
        .toList();
  }

  Future<List<EventModel>> getUserEvents() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;

    if (userId == null) return [];

    final regResponse = await Supabase.instance.client
        .from('registrations')
        .select('event_id')
        .eq('user_id', userId);

    if (regResponse.isEmpty) return [];

    final eventIds = regResponse
        .map((row) => row['event_id'] as String)
        .toList();

    final eventResponse = await Supabase.instance.client
        .from('events')
        .select()
        .inFilter('id', eventIds);

    return eventResponse
        .map((row) => EventModel.fromJson(row))
        .toList();
  }
}