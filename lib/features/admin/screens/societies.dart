import 'package:flutter/material.dart';
import 'package:my_gate_clone/utilis/appbar.dart';
import 'package:provider/provider.dart';
import '../provider/society_provider.dart';
import '../modal/society.dart';

class SocietyDetailsScreen extends StatefulWidget {
  final SocietyModal society;

  const SocietyDetailsScreen({super.key, required this.society});

  @override
  State<SocietyDetailsScreen> createState() => _SocietyDetailsScreenState();
}

class _SocietyDetailsScreenState extends State<SocietyDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController societyNameCrtl;
  late TextEditingController societyOwnerCrtl;
  late TextEditingController societyOwnerPhoneCrtl;
  late TextEditingController societyPasswordCrtl;
  late TextEditingController societyEmailCrtl;
  late TextEditingController societyAddressCrtl;

  late TextEditingController pincodeCrtl = TextEditingController();
  late TextEditingController cityCrtl = TextEditingController();
  late TextEditingController stateCrtl = TextEditingController();
  late TextEditingController flatsCrtl = TextEditingController();
  late TextEditingController towersCrtl = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    societyNameCrtl = TextEditingController(text: widget.society.societyName);
    societyPasswordCrtl = TextEditingController(
      text: widget.society.societyPassword,
    );
    societyOwnerCrtl = TextEditingController(text: widget.society.ownerName);
    societyOwnerPhoneCrtl = TextEditingController(
      text: widget.society.ownerPhone,
    );
    societyEmailCrtl = TextEditingController(text: widget.society.ownerEmail);
    societyAddressCrtl = TextEditingController(
      text: widget.society.societyAddress,
    );
    pincodeCrtl = TextEditingController(text: widget.society.pincode);
    cityCrtl = TextEditingController(text: widget.society.city);
    stateCrtl = TextEditingController(text: widget.society.state);
    flatsCrtl = TextEditingController(text: widget.society.total_flats);
    towersCrtl = TextEditingController(text: widget.society.total_towers);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SocietyProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: reuseAppBar(title: 'Society Details'),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Top Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/gate.png',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 20),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildTextField(
                        controller: societyNameCrtl,
                        label: 'Society Name',
                        validator: (v) => v == null || v.isEmpty
                            ? 'Enter society name'
                            : null,
                      ),
                      buildTextField(
                        controller: societyPasswordCrtl,
                        label: 'Set Password',
                        obscure: true,
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Enter password' : null,
                      ),
                      buildTextField(
                        controller: societyOwnerCrtl,
                        label: 'Owner Name',
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Enter owner name' : null,
                      ),
                      buildTextField(
                        controller: societyOwnerPhoneCrtl,
                        label: 'Owner Phone',
                        keyboardType: TextInputType.phone,
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Enter owner phone' : null,
                      ),
                      buildTextField(
                        controller: societyEmailCrtl,
                        label: 'Owner Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) {
                          if (v != null && v.isNotEmpty) {
                            final emailRegex = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                            );
                            if (!emailRegex.hasMatch(v))
                              return 'Enter valid email';
                          }
                          return null;
                        },
                      ),
                      buildTextField(
                        controller: cityCrtl,
                        label: 'City',
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Enter city name' : null,
                      ),
                      buildTextField(
                        controller: pincodeCrtl,
                        label: 'Pincode',
                        keyboardType: TextInputType.phone,
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Enter pincode' : null,
                      ),
                      buildTextField(
                        controller: stateCrtl,
                        label: 'State',
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Enter state name' : null,
                      ),
                      buildTextField(
                        controller: towersCrtl,
                        label: 'Total Towers',
                        keyboardType: TextInputType.phone,
                        validator: (v) => v == null || v.isEmpty
                            ? 'Enter total towers'
                            : null,
                      ),
                      buildTextField(
                        controller: flatsCrtl,
                        label: 'Total Flats',
                        keyboardType: TextInputType.phone,
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Enter total flats' : null,
                      ),
                      buildTextField(
                        controller: societyAddressCrtl,
                        label: 'Society Address',
                        validator: (v) => v == null || v.isEmpty
                            ? 'Enter society address'
                            : null,
                      ),
                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlueAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: isLoading
                                  ? null
                                  : () async {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() => isLoading = true);

                                        final updatedSociety = SocietyModal(
                                          id: widget.society.id,
                                          pincode: pincodeCrtl.text,
                                          city: cityCrtl.text,
                                          state: stateCrtl.text,
                                          total_flats: flatsCrtl.text,
                                          total_towers: towersCrtl.text,
                                          societyName: societyNameCrtl.text,
                                          societyPassword:
                                              societyPasswordCrtl.text,
                                          ownerName: societyOwnerCrtl.text,
                                          ownerPhone:
                                              societyOwnerPhoneCrtl.text,
                                          ownerEmail: societyEmailCrtl.text,
                                          societyAddress:
                                              societyAddressCrtl.text,
                                        );

                                        try {
                                          await provider.updateSociety(
                                            widget.society.id,
                                            updatedSociety,
                                          );

                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                "Society Updated Successfully!",
                                              ),
                                            ),
                                          );
                                        } catch (e) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text("Error: $e"),
                                            ),
                                          );
                                        }

                                        setState(() => isLoading = false);
                                      }
                                    },
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      "Update",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: isLoading
                                  ? null
                                  : () async {
                                      final confirm = await showDialog<bool>(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: const Text("Confirm Delete"),
                                          content: const Text(
                                            "Are you sure you want to delete this society?",
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(ctx, false),
                                              child: const Text("Cancel"),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(ctx, true),
                                              child: const Text("Delete"),
                                            ),
                                          ],
                                        ),
                                      );

                                      if (confirm == true) {
                                        setState(() => isLoading = true);

                                        try {
                                          await provider.deleteSociety(
                                            widget.society.id,
                                          );
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                "Society Deleted Successfully!",
                                              ),
                                            ),
                                          );
                                          Navigator.pop(context); // go back
                                        } catch (e) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text("Error: $e"),
                                            ),
                                          );
                                        }

                                        setState(() => isLoading = false);
                                      }
                                    },
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      "Delete",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Reusable text field widget function
Widget buildTextField({
  required TextEditingController controller,
  required String label,
  TextInputType keyboardType = TextInputType.text,
  bool obscure = false,
  String? Function(String?)? validator,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      validator: validator,
    ),
  );
}
