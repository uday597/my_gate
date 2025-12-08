import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_gate_clone/utilis/appbar.dart';

class EventsScreen extends StatelessWidget {
  EventsScreen({super.key});

  final List<Map<String, dynamic>> sampleEvents = [
    {
      "title": "Diwali Celebration",
      "description": "Join us for lighting, music and sweets!",
      "date": DateTime(2025, 11, 5),
      "image":
          "https://static.toiimg.com/thumb/msid-124620416,width-1280,height-720,resizemode-4/124620416.jpg",
    },
    {
      "title": "Society Cricket Match",
      "description":
          "Friendly match at the central ground. All residents invited.",
      "date": DateTime(2025, 10, 12),
      "image":
          "https://images.pexels.com/photos/114296/pexels-photo-114296.jpeg",
    },
    {
      "title": "Blood Donation Camp",
      "description": "Help save lives by donating blood!",
      "date": DateTime(2025, 9, 29),
      "image":
          "https://images.pexels.com/photos/339620/pexels-photo-339620.jpeg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: reuseAppBar(title: 'Events'),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sampleEvents.length,
        itemBuilder: (context, index) {
          final event = sampleEvents[index];

          return EventCard(
            title: event["title"],
            description: event["description"],
            date: event["date"],
            imageUrl: event["image"],
          );
        },
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String title;
  final String description;
  final DateTime date;
  final String imageUrl;

  const EventCard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(.10),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            child: Image.network(
              imageUrl,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(14),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 6),

                // EVENT DESCRIPTION
                Text(
                  description,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),

                const SizedBox(height: 12),

                // DATE BADGE
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.lightBlue, Colors.teal],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "📅  ${DateFormat('dd MMM yyyy').format(date)}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
