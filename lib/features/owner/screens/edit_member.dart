import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:my_gate_clone/utilis/appbar.dart';
import 'package:my_gate_clone/features/owner/modal/members_modal.dart';
import 'package:my_gate_clone/features/owner/provider/members_provider.dart';

class EditMemberInfo extends StatefulWidget {
  final int memberId;
  const EditMemberInfo({super.key, required this.memberId});

  @override
  State<EditMemberInfo> createState() => _EditMemberInfoState();
}

class _EditMemberInfoState extends State<EditMemberInfo> {
  MembersModal? member;
  final _formKey = GlobalKey<FormState>();

  final picker = ImagePicker();
  File? pickedImageFile;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController flatController;

  @override
  void initState() {
    super.initState();

    final provider = Provider.of<MembersProvider>(context, listen: false);
    member = provider.members.firstWhere((m) => m.id == widget.memberId);

    // Initialize controllers with existing values
    nameController = TextEditingController(text: member!.memberName);
    emailController = TextEditingController(text: member!.memberEmail);
    phoneController = TextEditingController(text: member!.memberPhone);
    addressController = TextEditingController(text: member!.memberAddress);
    flatController = TextEditingController(text: member!.memberFlatNo);
  }

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        pickedImageFile = File(picked.path);
      });
    }
  }

  Future<void> updateMember() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = Provider.of<MembersProvider>(context, listen: false);

    String? imageUrl = member!.memberImage;

    // Upload new image if picked
    if (pickedImageFile != null) {
      final uploadedUrl = await provider.uploadImage(pickedImageFile!);
      if (uploadedUrl != null) {
        imageUrl = uploadedUrl;
      }
    }

    final updatedMember = MembersModal(
      id: member!.id,
      societyId: member!.societyId,
      memberName: nameController.text.trim(),
      memberEmail: emailController.text.trim(),
      memberPhone: phoneController.text.trim(),
      memberAddress: addressController.text.trim(),
      memberFlatNo: flatController.text.trim(),
      memberImage: imageUrl,
    );

    await provider.updateMember(updatedMember, updatedMember);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Member updated successfully")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: reuseAppBar(title: "Edit Member"),
      body: member == null
          ? const Center(child: Text("Member not found"))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 65,
                              backgroundImage: pickedImageFile != null
                                  ? FileImage(pickedImageFile!)
                                  : (member!.memberImage != null &&
                                        member!.memberImage!.isNotEmpty &&
                                        member!.memberImage!.startsWith("http"))
                                  ? NetworkImage(member!.memberImage!)
                                  : const AssetImage(
                                          "assets/default_avatar.png",
                                        )
                                        as ImageProvider,
                            ),
                          ),
                          const SizedBox(height: 8),
                          InkWell(
                            onTap: pickImage,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue.shade50,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(
                                  Icons.edit,
                                  size: 18,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Form Card
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      shadowColor: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          children: [
                            buildInputField(
                              controller: nameController,
                              label: "Full Name",
                              icon: Icons.person,
                              validator: (v) =>
                                  v!.isEmpty ? "Enter full name" : null,
                            ),

                            buildInputField(
                              controller: emailController,
                              label: "Email",
                              icon: Icons.email,
                            ),

                            buildInputField(
                              controller: phoneController,
                              label: "Phone Number",
                              icon: Icons.phone,
                            ),

                            buildInputField(
                              controller: addressController,
                              label: "Address",
                              icon: Icons.location_on,
                            ),

                            buildInputField(
                              controller: flatController,
                              label: "Flat Number",
                              icon: Icons.home,
                              validator: (v) =>
                                  v!.isEmpty ? "Flat number required" : null,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Update Button
                    ElevatedButton(
                      onPressed: updateMember,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 55),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                      child: const Text(
                        "Update Member",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  // Reusable TextField widget
  Widget buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.blue),
          labelText: label,
          labelStyle: const TextStyle(fontSize: 15),
          filled: true,
          fillColor: Colors.grey.shade100,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.blue),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
