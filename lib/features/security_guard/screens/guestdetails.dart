import 'package:flutter/material.dart';

class GuestRequestDetailForGuard extends StatelessWidget {
  final Map<String, dynamic> requestData;

  const GuestRequestDetailForGuard({super.key, required this.requestData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Guest Request Details")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        requestData['guest_image'] != null &&
                            requestData['guest_image'] != ""
                        ? NetworkImage(requestData['guest_image'])
                        : const AssetImage("assets/images/guest.png")
                              as ImageProvider,
                  ),
                ),
                const SizedBox(height: 20),
                infoRow("Guest Name", requestData['guest_name']),
                infoRow("Phone", requestData['guest_phone']),
                infoRow("Address", requestData['guest_address'] ?? "N/A"),
                infoRow("Status", requestData['status']),
                infoRow(
                  "Created At",
                  requestData['created_at']?.toString().split(".").first ?? "",
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text("Back"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            "$title: ",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
