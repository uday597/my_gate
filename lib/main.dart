import 'package:flutter/material.dart';
import 'package:my_gate_clone/features/admin/provider/society_provider.dart';
import 'package:my_gate_clone/features/members/providers/guest.dart';
import 'package:my_gate_clone/features/members/providers/login_provider.dart';
import 'package:my_gate_clone/features/owner/provider/login_provider.dart';
import 'package:my_gate_clone/features/owner/provider/members_provider.dart';
import 'package:my_gate_clone/features/owner/provider/security_guard.dart';
import 'package:my_gate_clone/features/security_guard/providers/login.dart';
import 'package:my_gate_clone/routing/routing.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://nnlhbdspkhcyeoeciplg.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5ubGhiZHNwa2hjeWVvZWNpcGxnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQ3MDQ4ODgsImV4cCI6MjA4MDI4MDg4OH0.zVkm9kUHc-Td7niSafLOfwkS3ayPJU5yAy7JxCsLGHs';

Future<void> main() async {
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RequestProvider()),
        ChangeNotifierProvider(create: (_) => SecurityGuardLoginProvider()),
        ChangeNotifierProvider(create: (_) => SecurityGuardProvider()),
        ChangeNotifierProvider(create: (_) => MembersLoginProvider()),
        ChangeNotifierProvider(create: (_) => MembersProvider()),
        ChangeNotifierProvider(create: (_) => SocietyProvider()),
        ChangeNotifierProvider(create: (_) => OwnerLoginProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: AppRouting.routes,
      title: 'My gate',
      theme: ThemeData(),
    );
  }
}
