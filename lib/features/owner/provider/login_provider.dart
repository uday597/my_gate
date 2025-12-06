import 'package:flutter/material.dart';
import 'package:my_gate_clone/features/admin/modal/society.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OwnerLoginProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;

  bool isloading = false;
  SocietyModal? ownerLogged;

  Future<String?> loginOwner({
    required String ownerEmail,
    required String societyPassword,
  }) async {
    try {
      isloading = true;
      notifyListeners();

      final response = await supabase
          .from('societies')
          .select()
          .eq('owner_email', ownerEmail)
          .eq('society_password', societyPassword)
          .maybeSingle();

      if (response == null) {
        isloading = false;
        notifyListeners();
        return "Invalid email or password!";
      }

      ownerLogged = SocietyModal.fromMap(response);

      isloading = false;
      notifyListeners();
      return null;
    } catch (e) {
      isloading = false;
      notifyListeners();
      return "Something went wrong: $e";
    }
  }
}
