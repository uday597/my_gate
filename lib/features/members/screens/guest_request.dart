import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gate_clone/utilis/appbar.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../owner/modal/members_modal.dart';
import '../providers/guest.dart';

class GuestRequestScreen extends StatefulWidget {
  final MembersModal member;

  const GuestRequestScreen({super.key, required this.member});

  @override
  State<GuestRequestScreen> createState() => _GuestRequestScreenState();
}

class _GuestRequestScreenState extends State<GuestRequestScreen> {
  final _formKey = GlobalKey<FormState>();

  final guestName = TextEditingController();
  final guestPhone = TextEditingController();
  final guestAddress = TextEditingController();

  File? imageFile;

  @override
  void initState() {
    super.initState();
    Provider.of<RequestProvider>(
      context,
      listen: false,
    ).fetchRequests(widget.member.societyId);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RequestProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xfff2f5f7),
      appBar: reuseAppBar(title: 'Guest Request'),
      body: RefreshIndicator(
        onRefresh: () => provider.fetchRequests(widget.member.societyId),

        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                _buildAddRequestCard(),

                const SizedBox(height: 15),

                provider.requests.isEmpty
                    ? Column(
                        children: [
                          const SizedBox(height: 40),
                          Image.asset("assets/empty.png", height: 180),
                          const SizedBox(height: 10),
                          const Text(
                            "No Requests Found",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.requests.length,
                        itemBuilder: (context, i) =>
                            _buildRequestCard(provider.requests[i], provider),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddRequestCard() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: ExpansionTile(
          iconColor: Colors.blue,
          collapsedIconColor: Colors.blue,
          title: const Text(
            "Add Guest Request",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          children: [
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField(guestName, "Guest Name"),
                  const SizedBox(height: 12),
                  _buildTextField(
                    guestPhone,
                    "Guest Phone",
                    inputType: TextInputType.phone,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(guestAddress, "Guest Address"),
                  const SizedBox(height: 12),

                  // Image Picker
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: pickImage,
                        icon: const Icon(Icons.image),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        label: const Text("Pick Image"),
                      ),
                      const SizedBox(width: 12),
                      if (imageFile != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            imageFile!,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => addRequest(
                        Provider.of<RequestProvider>(context, listen: false),
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Submit Request",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestCard(req, RequestProvider provider) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: req.guestImage != null && req.guestImage!.isNotEmpty
                  ? Image.network(
                      req.guestImage!,
                      width: 65,
                      height: 65,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: 65,
                      height: 65,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.person, size: 35),
                    ),
            ),

            const SizedBox(width: 12),

            // DETAILS
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    req.guestName,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text("📞 ${req.guestPhone}"),
                  Text("📍 ${req.guestAddress ?? '--'}"),
                  const SizedBox(height: 5),

                  // STATUS BADGE
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _statusColor(req.status),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      req.status.toUpperCase(),
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),

                  const SizedBox(height: 4),
                  Text(
                    "🕒 ${req.createdAt.toLocal()}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            IconButton(
              icon: const Icon(Icons.qr_code_2, color: Colors.blue),
              onPressed: () {
                if (req.qrCode != null && req.qrCode.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GuestQRCodeScreen(
                        qrData: req.qrCode!,
                        guestName: req.guestName,
                      ),
                    ),
                  );
                }
              },
            ),

            // DELETE BUTTON
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => confirmDelete(provider, req.id),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController c,
    String label, {
    TextInputType inputType = TextInputType.text,
  }) {
    return TextFormField(
      controller: c,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (v) => v!.isEmpty ? "Enter $label" : null,
    );
  }

  // STATUS COLOR
  Color _statusColor(String s) {
    switch (s) {
      case "pending":
        return Colors.orange;
      case "approved":
        return Colors.green;
      case "rejected":
        return Colors.red;
      default:
        return Colors.blueGrey;
    }
  }

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => imageFile = File(picked.path));
    }
  }

  Future<void> addRequest(RequestProvider provider) async {
    if (!_formKey.currentState!.validate()) return;

    final ok = await provider.addGuestRequest(
      societyId: widget.member.societyId,
      memberId: widget.member.id,
      guestName: guestName.text,
      guestPhone: guestPhone.text,
      guestAddress: guestAddress.text,
      guestImageFile: imageFile,
    );

    if (ok) {
      guestName.clear();
      guestPhone.clear();
      guestAddress.clear();
      imageFile = null;

      await provider.fetchRequests(widget.member.societyId);
      setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Request Submitted Successfully"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  // DELETE REQUEST
  Future<void> confirmDelete(RequestProvider provider, int id) async {
    bool? ok = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Request?"),
        content: const Text("Are you sure you want to delete this request?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (ok == true) {
      await provider.deleteRequest(id, widget.member.societyId);
    }
  }
}

class GuestQRCodeScreen extends StatelessWidget {
  final String qrData;
  final String guestName;

  const GuestQRCodeScreen({
    super.key,
    required this.qrData,
    required this.guestName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("QR Code for $guestName")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QrImageView(data: qrData, size: 250, version: QrVersions.auto),
              const SizedBox(height: 20),
              const Text(
                "Share this QR with your guest.\nSecurity guard will scan it.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
