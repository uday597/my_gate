import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NoticeProvider with ChangeNotifier {
  final supabase = Supabase.instance.client;

  List<Map<String, dynamic>> _notices = [];
  List<Map<String, dynamic>> get notices => _notices;

  bool isLoading = false;

  // ADD NEW NOTICE
  Future<void> addNotice({
    required int societyId,
    required String notice,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      await supabase.from('notice').insert({
        'society_id': societyId,
        'notice': notice,
      });

      await getNotices(societyId); // refresh list
    } catch (e) {
      debugPrint("Error adding notice: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  // GET ALL NOTICES

  Future<void> getNotices(int societyId) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await supabase
          .from('notice')
          .select('*')
          .eq('society_id', societyId)
          .order('created_at', ascending: false);

      _notices = List<Map<String, dynamic>>.from(response);
    } catch (e) {
      debugPrint("Error fetching notices: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // DELETE NOTICE
  Future<void> deleteNotice(int noticeId, int societyId) async {
    try {
      await supabase.from('notice').delete().eq('id', noticeId);
      await getNotices(societyId);
    } catch (e) {
      debugPrint("Error deleting notice: $e");
    }
  }

  Future<void> updateNotice({
    required int noticeId,
    required String noticeText,
    required int societyId,
  }) async {
    try {
      await supabase
          .from('notice')
          .update({'notice': noticeText})
          .eq('id', noticeId);

      await getNotices(societyId);
    } catch (e) {
      debugPrint("Error updating notice: $e");
    }
  }
}
