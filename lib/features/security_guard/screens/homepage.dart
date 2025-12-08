import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_gate_clone/features/owner/modal/security_guard.dart';
import 'package:my_gate_clone/features/security_guard/screens/contact_us.dart';
import 'package:my_gate_clone/features/security_guard/screens/scanner.dart';
import 'package:my_gate_clone/features/security_guard/screens/visitors.dart';
import 'package:my_gate_clone/utilis/appbar.dart';

class GuardHomepage extends StatelessWidget {
  final SecurityGuardModal guard;

  const GuardHomepage({super.key, required this.guard});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reuseAppBar(title: "Guard Dashboard"),
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => showGuardInfo(context),
              child: Card(
                color: Colors.white,
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: guard.profileImage != null
                            ? NetworkImage(guard.profileImage!)
                            : const AssetImage("assets/images/guard.png")
                                  as ImageProvider,
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              guard.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Phone: ${guard.phone}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Quick Actions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                buildMenuButton(
                  icon: Icons.group,
                  title: "Visitors List",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            VisitorsList(societyId: guard.societyId),
                      ),
                    );
                  },
                ),
                buildMenuButton(
                  icon: Icons.qr_code_scanner,
                  title: "Scan QR",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GuardQRScannerScreen(),
                      ),
                    );
                  },
                ),
                buildMenuButton(
                  icon: Icons.phone,
                  title: "Contact us",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ContactUs(societyId: guard.societyId),
                      ),
                    );
                  },
                ),
                buildMenuButton(
                  icon: Icons.logout,
                  title: "Logout",
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text("Logged Out")));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// POPUP UI FOR MORE INFORMATION
  void showGuardInfo(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 15),

              CircleAvatar(
                radius: 45,
                backgroundImage: guard.profileImage != null
                    ? NetworkImage(guard.profileImage!)
                    : const AssetImage("assets/images/guard.png")
                          as ImageProvider,
              ),
              const SizedBox(height: 15),

              Text(
                guard.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),

              infoTile("Phone Number", guard.phone),
              infoTile("Address", guard.address),
              infoTile("Society ID", guard.societyId.toString()),
              infoTile(
                "Joined On",
                guard.createdAt != null
                    ? DateFormat(
                        'dd MMM yyyy, hh:mm a',
                      ).format(DateTime.parse(guard.createdAt!))
                    : "No date",
              ),

              const SizedBox(height: 15),
            ],
          ),
        );
      },
    );
  }

  /// REUSABLE INFO ROW
  Widget infoTile(String title, String value) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Row(
          children: [
            Text(
              "$title: ",
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(fontSize: 15, color: Colors.black54),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildMenuButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 45, color: Colors.lightBlueAccent),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
