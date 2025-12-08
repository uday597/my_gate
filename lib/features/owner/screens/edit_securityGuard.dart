import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gate_clone/features/owner/modal/security_guard.dart';
import 'package:my_gate_clone/features/owner/provider/security_guard.dart';
import 'package:my_gate_clone/utilis/appbar.dart';
import 'package:provider/provider.dart';

class EditSecurityGuardScreen extends StatefulWidget {
  final SecurityGuardModal guard;

  const EditSecurityGuardScreen({super.key, required this.guard});

  @override
  State<EditSecurityGuardScreen> createState() =>
      _EditSecurityGuardScreenState();
}

class _EditSecurityGuardScreenState extends State<EditSecurityGuardScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  File? pickedImageFile;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.guard.name);
    phoneController = TextEditingController(text: widget.guard.phone);
    addressController = TextEditingController(text: widget.guard.address);
  }

  Future pickImage() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        pickedImageFile = File(file.path);
      });
    }
  }

  Future updateGuard() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    final provider = Provider.of<SecurityGuardProvider>(context, listen: false);

    String? newImageUrl;

    if (pickedImageFile != null) {
      newImageUrl = await provider.uploadImage(pickedImageFile!);
    }

    final updatedGuard = SecurityGuardModal(
      id: widget.guard.id,
      societyId: widget.guard.societyId,
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      address: addressController.text.trim(),
      profileImage: newImageUrl ?? widget.guard.profileImage,
    );

    final success = await provider.updateGuard(updatedGuard);

    setState(() => isLoading = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Guard Updated Successfully")),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Update Failed")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reuseAppBar(title: 'Edit Information'),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // IMAGE
              GestureDetector(
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 55,
                  backgroundImage: pickedImageFile != null
                      ? FileImage(pickedImageFile!)
                      : (widget.guard.profileImage != null &&
                            widget.guard.profileImage!.startsWith("http"))
                      ? NetworkImage(widget.guard.profileImage!)
                      : const AssetImage("assets/default_avatar.png")
                            as ImageProvider,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.blue,
                      child: const Icon(Icons.edit, size: 18),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // NAME
              TextFormField(
                controller: nameController,
                decoration: input("Guard Name"),
                validator: (v) => v!.isEmpty ? "Name required" : null,
              ),

              const SizedBox(height: 15),

              // PHONE
              TextFormField(
                controller: phoneController,
                decoration: input("Phone Number"),
                keyboardType: TextInputType.phone,
                validator: (v) => v!.length < 10 ? "Enter valid number" : null,
              ),

              const SizedBox(height: 15),

              // ADDRESS
              TextFormField(
                controller: addressController,
                decoration: input("Address"),
                maxLines: 2,
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),

              const SizedBox(height: 25),

              // UPDATE BUTTON
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: isLoading ? null : updateGuard,
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Update", style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration input(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
