import 'package:flutter/material.dart';

PreferredSizeWidget reuseAppBar({
  required String title,
  List<Widget>? actions,
}) {
  return AppBar(
    elevation: 0,
    foregroundColor: Colors.black87,
    title: Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    actions: actions,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFB3E5FC), // lighter blue
            Color(0xFFFFF9C4), // lighter yellow
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    ),
    backgroundColor: Colors.transparent,
  );
}
