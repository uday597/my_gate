import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_gate_clone/features/members/modal/events.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EventProvider extends ChangeNotifier {
  final SupabaseClient supabase = Supabase.instance.client;

  List<EventsModal> events = [];
  bool isLoading = false;

  /// Fetch events for a society
  Future<void> fetchEvents(int societyId) async {
    isLoading = true;
    notifyListeners();

    try {
      // new syntax: data is directly returned
      final List<dynamic> data = await supabase
          .from('events')
          .select()
          .eq('society_id', societyId)
          .order('created_at', ascending: false);

      events = data.map((e) => EventsModal.fromMap(e)).toList();
    } catch (e) {
      print("Error fetching events: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  /// Upload image to Supabase storage and get URL
  Future<String?> uploadEventImage(File file) async {
    try {
      final ext = file.path.split('.').last;
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.$ext';

      // Upload file (no response returned in new SDK)
      await supabase.storage.from('events').upload(fileName, file);

      // Get public URL
      final url = supabase.storage.from('events').getPublicUrl(fileName);
      return url;
    } catch (e) {
      print("Image upload error: $e");
      return null;
    }
  }

  /// Add event
  Future<void> addEvent({
    required String title,
    required String description,
    String? imageUrl,
    required int societyId,
    required int memberId,
  }) async {
    final response = await supabase.from('events').insert({
      'title': title,
      'description': description,
      'image': imageUrl,
      'society_id': societyId,
      'member_id': memberId,
    });

    if (response.error == null) {
      events.insert(0, EventsModal.fromMap(response.data[0]));
      notifyListeners();
    }
  }

  /// Update event
  Future<void> updateEvent(EventsModal event) async {
    final response = await supabase
        .from('events')
        .update({
          'title': event.title,
          'description': event.description,
          'image': event.image,
        })
        .eq('id', event.id);

    if (response.error == null) {
      int index = events.indexWhere((e) => e.id == event.id);
      if (index != -1) {
        events[index] = event;
        notifyListeners();
      }
    }
  }

  /// Delete event
  Future<void> deleteEvent(int id) async {
    final response = await supabase.from('events').delete().eq('id', id);

    if (response.error == null) {
      events.removeWhere((e) => e.id == id);
      notifyListeners();
    }
  }
}
