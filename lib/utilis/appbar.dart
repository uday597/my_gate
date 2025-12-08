import 'package:flutter/material.dart';

PreferredSizeWidget reuseAppBar({
  required String title,
  List<Widget>? actions,
  VoidCallback? ontap,
}) {
  return AppBar(
    elevation: 0,
    foregroundColor: Colors.black87,

    title: Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),

    // 👇 SHOW FILTER ICON ONLY WHEN ontap IS NOT NULL
    actions: [
      if (ontap != null)
        IconButton(onPressed: ontap, icon: const Icon(Icons.filter_list)),

      // also include additional actions if passed
      if (actions != null) ...actions,
    ],

    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFB3E5FC), Color(0xFFFFF9C4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    ),
    backgroundColor: Colors.transparent,
  );
}
