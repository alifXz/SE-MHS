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

  Future<void> createEvent({
    required String title,
    required String organizer,
    required String location,
    required String locationLink,
    required String description,
    required String imageUrl,
    required String startTime,
    required String endTime,
    required String eventDate,
    required String venuePartner,
    required int price,
  }) async {

    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception('User not logged in');
    }

    await supabase.from('events').insert({
      'title': title,
      'organizer': organizer,
      'location': location,
      'location_link': locationLink,
      'description': description,
      'image_url': imageUrl,
      'start_time': startTime,
      'end_time': endTime,
      'event_date': eventDate,
      'venue_partner': venuePartner,
      'price': price,
    });
  }
}