import 'package:flutter_final_project_kintkin/models/event_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  Future<void> joinEvent({
    required EventModel event,
  }) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('User not logged in');
    }

    await supabase.from('registrations').insert({
      'user_id': user.uid,
      'event_id': event.id,
      'payment_status': 'paid',
    });
  }
}