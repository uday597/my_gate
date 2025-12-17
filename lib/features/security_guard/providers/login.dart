import 'package:flutter/material.dart';
import 'package:my_gate_clone/features/owner/modal/security_guard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SecurityGuardLoginProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;
  bool isLoading = false;
  SecurityGuardModal? guardLogin;
  Future<String?> loginGuard({required String phone}) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await supabase
          .from('security_guard')
          .select('''*,societies:society_id(society_name)''')
          .eq('phone', phone)
          .maybeSingle();

      isLoading = false;
      notifyListeners();

      if (response == null) {
        return "Invalid phone number!";
      }

      guardLogin = SecurityGuardModal.fromMap(response);
      return null;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return "Something went wrong: $e";
    }
  }
}
