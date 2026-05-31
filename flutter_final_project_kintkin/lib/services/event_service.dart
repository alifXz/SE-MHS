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

  Future<List<EventModel>> searchEvents(String query) async {
    final response = await supabase
        .from('events')
        .select()
        .ilike('title', '%$query%');
    
    return response
      .map<EventModel>((json) => EventModel.fromJson(json))
      .toList();
    }
}