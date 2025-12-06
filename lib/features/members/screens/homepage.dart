import 'package:flutter/material.dart';
import 'package:my_gate_clone/features/members/screens/guest_request.dart';
import 'package:my_gate_clone/features/owner/modal/members_modal.dart';
import 'package:my_gate_clone/utilis/appbar.dart';

class MemberHomepage extends StatelessWidget {
  final MembersModal member;

  const MemberHomepage({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: reuseAppBar(title: "Member Dashboard"),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// PROFILE HEADER (click to open bottom sheet)
            GestureDetector(
              onTap: () => showMemberInfo(context),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFB3E5FC), Color(0xFFFFF9C4)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            member.memberImage != null &&
                                member.memberImage!.isNotEmpty
                            ? NetworkImage(member.memberImage!)
                            : const AssetImage("assets/images/user.png")
                                  as ImageProvider,
                      ),
                      const SizedBox(width: 20),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              member.memberName,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Flat No: ${member.memberFlatNo}",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black45,
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

            /// QUICK ACTION BUTTONS
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                buildMenuButton(
                  icon: Icons.people,
                  title: "Family Members",
                  onTap: () {},
                ),
                buildMenuButton(
                  icon: Icons.front_hand,
                  title: "Request",
                  onTap: () => showRequestOptions(context),
                ),
                buildMenuButton(
                  icon: Icons.notifications,
                  title: "Society Notices",
                  onTap: () {},
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

  void showMemberInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// INDICATOR
                Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 15),

                CircleAvatar(
                  radius: 45,
                  backgroundImage:
                      member.memberImage != null &&
                          member.memberImage!.isNotEmpty
                      ? NetworkImage(member.memberImage!)
                      : const AssetImage("assets/images/user.png")
                            as ImageProvider,
                ),
                const SizedBox(height: 15),

                Text(
                  member.memberName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                infoCard("Email", member.memberEmail),
                infoCard("Phone", member.memberPhone),
                infoCard("Flat No", member.memberFlatNo),
                infoCard("Address", member.memberAddress),
                infoCard("Society ID", member.societyId.toString()),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  /// REUSABLE CARD FOR INFO
  Widget infoCard(String title, String value) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
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
      ),
    );
  }

  void showRequestOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Guest Request",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              ListTile(
                leading: const Icon(Icons.add_circle, color: Colors.green),
                title: const Text("Add Guest Request"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GuestRequestScreen(member: member),
                    ),
                  );
                },
              ),

              ListTile(
                leading: const Icon(Icons.list_alt, color: Colors.blue),
                title: const Text("View My Requests"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GuestRequestScreen(member: member),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// REUSABLE QUICK ACTION BUTTON
  Widget buildMenuButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: Colors.lightBlueAccent),
              const SizedBox(height: 5),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
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
