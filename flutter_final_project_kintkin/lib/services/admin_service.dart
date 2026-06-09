import 'package:supabase_flutter/supabase_flutter.dart';

class AdminService {
  final _supabase = Supabase.instance.client;

  Future<int> getTotalParticipants() async {
    final response = await _supabase
        .from('registrations')
        .select();

    return response.length;
  }

  Future<int> getActiveEvents() async {
    final today = DateTime.now().toIso8601String().split('T').first;

    final response = await _supabase
        .from('events')
        .select()
        .gte('event_date', today);

    return response.length;
  }

  Future<int> getTotalRevenue() async {
    final registrations = await _supabase
        .from('registrations')
        .select('event_id');

    int revenue = 0;

    for (final registration in registrations) {
      final event = await _supabase
          .from('events')
          .select('price')
          .eq('id', registration['event_id'])
          .maybeSingle();

      if (event != null) {
        revenue += (event['price'] as int?) ?? 0;
      }
    }

    return revenue;
  }

  Future<int> getTotalUsers() async {
    final response = await _supabase
        .from('users')
        .select();

    return response.length;
  }
}