import 'package:flutter/material.dart';
import 'package:my_gate_clone/features/members/modal/event_response.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EventResponseProvider extends ChangeNotifier {
  final SupabaseClient supabase = Supabase.instance.client;

  List<EventResponseModal> responses = [];
  bool isLoading = false;

  /// Fetch responses for an event
  Future<void> fetchResponses(int eventId) async {
    isLoading = true;
    notifyListeners();

    try {
      final List<dynamic> data = await supabase
          .from('event_responses')
          .select()
          .eq('event_id', eventId)
          .order('created_at', ascending: true);

      responses = data.map((e) => EventResponseModal.fromMap(e)).toList();
    } catch (e) {
      print("Error fetching responses: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  /// Add response
  Future<void> addResponse({
    required int eventId,
    required int memberId,
    required String type, // 'like' or 'comment'
    String? comment,
  }) async {
    try {
      final List<dynamic> data = await supabase.from('event_responses').insert({
        'event_id': eventId,
        'member_id': memberId,
        'type': type,
        'comment': comment,
      }).select(); // Use .select() to get inserted row

      if (data.isNotEmpty) {
        responses.add(EventResponseModal.fromMap(data[0]));
        notifyListeners();
      }
    } catch (e) {
      print("Error adding response: $e");
    }
  }

  /// Delete response
  Future<void> deleteResponse(int id) async {
    try {
      await supabase.from('event_responses').delete().eq('id', id);
      responses.removeWhere((r) => r.id == id);
      notifyListeners();
    } catch (e) {
      print("Error deleting response: $e");
    }
  }
}
