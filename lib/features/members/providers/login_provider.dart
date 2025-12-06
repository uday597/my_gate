import 'package:flutter/material.dart';
import 'package:my_gate_clone/features/owner/modal/members_modal.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MembersLoginProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;

  bool isLoading = false;
  MembersModal? memberLogged;

  Future<MembersModal?> loginMember({
    required String memberEmail,
    required String memberPassword,
  }) async {
    try {
      final response = await supabase
          .from("members")
          .select()
          .eq("member_email", memberEmail)
          .eq("flat_no", memberPassword)
          .maybeSingle();

      if (response != null) {
        return MembersModal.fromMap(response);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
