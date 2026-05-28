import 'package:flutter_final_project_kintkin/models/event_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  Future<void> joinEvent({
    required EventModel event,
  }) async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      throw Exception('User not logged in');
    }

    await supabase.from('registrations').insert({
      'user_id': user.id,
      'event_id': event.id,
      'payment_status': 'paid',
    });
  }
}