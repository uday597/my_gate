import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_gate_clone/features/members/modal/guest_modal.dart';
import 'package:my_gate_clone/features/members/providers/guest.dart';
import 'package:my_gate_clone/features/security_guard/modal/visitors.dart';
import 'package:my_gate_clone/features/security_guard/providers/visitor.dart';
import 'package:provider/provider.dart';

class VisitorsList extends StatefulWidget {
  final int societyId;
  const VisitorsList({super.key, required this.societyId});

  @override
  State<VisitorsList> createState() => _VisitorsListState();
}

class _VisitorsListState extends State<VisitorsList> {
  String selectedFilter = "All";

  @override
  void initState() {
    super.initState();
    Provider.of<RequestProvider>(
      context,
      listen: false,
    ).fetchRequests(widget.societyId);

    Provider.of<VisitorProvider>(
      context,
      listen: false,
    ).fetchVisitors(widget.societyId);
  }

  void resetFilter() {
    setState(() {
      selectedFilter = "All";
      selectedDate = null;
    });
  }

  void pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    final requestProvider = Provider.of<RequestProvider>(context);
    final visitorProvider = Provider.of<VisitorProvider>(context);

    /// Combine both lists
    List<dynamic> combinedList = [
      ...requestProvider.requests,
      ...visitorProvider.visitorList,
    ];

    /// Apply filter
    List<dynamic> filteredList = combinedList.where((item) {
      final status = item.status.toLowerCase();
      bool statusMatch =
          selectedFilter == "All" || status == selectedFilter.toLowerCase();
      DateTime createdAt = item is VisitorModal
          ? item.createdAt
          : (item as GuestRequest).createdAt;
      bool dateMatch = true;
      if (selectedDate != null) {
        dateMatch =
            createdAt.year == selectedDate!.year &&
            createdAt.month == selectedDate!.month &&
            createdAt.day == selectedDate!.day;
      }
      return statusMatch && dateMatch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF373B44), Color(0xFF4286F4)],
            ),
          ),
        ),
        foregroundColor: Colors.white,
        title: Text(
          'Visitors List',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              pickDate();
            },
            icon: Icon(Icons.calendar_month),
          ),
          IconButton(onPressed: resetFilter, icon: Icon(Icons.refresh)),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Visitors Coming',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            /// Filter buttons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  filterChip("All"),
                  filterChip("approved"),
                  filterChip("pending"),
                  filterChip("rejected"),
                ],
              ),
            ),

            const SizedBox(height: 12),

            /// LIST
            Expanded(
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final visitor = filteredList[index];

                  /// IMAGE FIXED
                  String? image;
                  if (visitor is VisitorModal) {
                    image = visitor.image;
                  } else if (visitor is GuestRequest) {
                    image = visitor.guestImage;
                  }

                  /// DATE FIXED
                  final formattedDate = DateFormat('dd MMM yyyy, hh:mm a')
                      .format(
                        visitor is VisitorModal
                            ? visitor.createdAt
                            : (visitor as GuestRequest).createdAt,
                      );

                  return visitorCard(visitor, image, formattedDate);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Filter Chips
  Widget filterChip(String label) {
    return ChoiceChip(
      label: Text(label.toUpperCase()),
      selected: selectedFilter == label,
      onSelected: (value) {
        setState(() {
          selectedFilter = label;
        });
      },
    );
  }

  /// VISITOR Details method
  Widget visitorCard(dynamic visitor, String? image, String date) {
    final String name = (visitor is VisitorModal)
        ? visitor.name
        : (visitor as GuestRequest).guestName;

    final String phone = (visitor is VisitorModal)
        ? visitor.phone
        : (visitor as GuestRequest).guestPhone;

    final String Relative = (visitor is VisitorModal)
        ? visitor.relative
        : (visitor as GuestRequest).memberName.toString();
    final String flatNo = (visitor is VisitorModal)
        ? visitor.flatNo
        : (visitor as GuestRequest).memberFlatNo.toString();

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          /// IMAGE
          Container(
            width: 90,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: (image != null && image.isNotEmpty)
                    ? NetworkImage(image)
                    : const AssetImage("assets/images/members.png")
                          as ImageProvider,
              ),
            ),
          ),

          const SizedBox(width: 15),

          /// TEXT DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// NAME
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),
                Row(children: [Text('Relative:$Relative')]),
                const SizedBox(height: 4),

                /// PHONE
                Row(
                  children: [
                    const Icon(Icons.phone, size: 16, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(phone),
                  ],
                ),

                const SizedBox(height: 4),

                /// FLAT or ADDRESS
                Row(
                  children: [
                    const Icon(Icons.home, size: 16, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(flatNo),
                  ],
                ),

                const SizedBox(height: 4),

                /// DATE
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(date),
                  ],
                ),

                const SizedBox(height: 6),

                /// STATUS BADGE
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: visitor.status == "approved"
                        ? Colors.green.withOpacity(0.15)
                        : visitor.status == "rejected"
                        ? Colors.red.withOpacity(0.15)
                        : Colors.orange.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    visitor.status.toUpperCase(),
                    style: TextStyle(
                      color: visitor.status == "approved"
                          ? Colors.green
                          : visitor.status == "rejected"
                          ? Colors.red
                          : Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
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
