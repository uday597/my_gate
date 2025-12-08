import 'package:flutter/material.dart';
import 'package:my_gate_clone/features/members/screens/guest_request.dart';
import 'package:my_gate_clone/features/members/screens/notice.dart';
import 'package:my_gate_clone/features/members/screens/service_providers.dart';
import 'package:my_gate_clone/features/members/screens/view_requests.dart';
import 'package:my_gate_clone/features/owner/modal/members_modal.dart';
import 'package:my_gate_clone/utilis/appbar.dart';

class MemberHomepage extends StatelessWidget {
  final MembersModal member;

  const MemberHomepage({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: reuseAppBar(title: "Member Dashboard"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //profile header
            GestureDetector(
              onTap: () => showMemberInfo(context),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFB3E5FC), // lighter blue
                      Color(0xFFFFF9C4),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF667EEA).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 32,
                          backgroundImage:
                              member.memberImage != null &&
                                  member.memberImage!.isNotEmpty
                              ? NetworkImage(member.memberImage!)
                              : const AssetImage("assets/images/user.png")
                                    as ImageProvider,
                        ),
                      ),
                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello, ${member.memberName.split(' ').first}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Flat No: ${member.memberFlatNo}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                "Active Member",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, size: 20),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            const SizedBox(height: 12),

            const Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2D3748),
              ),
            ),

            const SizedBox(height: 16),

            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildActionButton(
                  icon: Icons.handshake_rounded,
                  title: "Quick Help",
                  color: const Color(0xFF667EEA),
                ),
                _buildActionButton(
                  icon: Icons.front_hand_outlined,
                  title: "Request",
                  color: const Color(0xFF48BB78),
                  onTap: () => showRequestOptions(context),
                ),
                _buildActionButton(
                  icon: Icons.list_alt,
                  title: "All Requests",
                  color: const Color(0xFFED8936),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            GuestRequestListScreen(societyId: member.societyId),
                      ),
                    );
                  },
                ),
                _buildActionButton(
                  icon: Icons.list_alt,
                  title: "Services",
                  color: const Color(0xFFED2936),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MemberServiceProvidersScreen(
                          societyId: member.societyId,
                        ),
                      ),
                    );
                  },
                ),
                _buildActionButton(
                  icon: Icons.notifications_outlined,
                  title: "Notices",
                  color: const Color(0xFF9F7AEA),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MemberNoticeList(societyId: member.societyId),
                      ),
                    );
                  },
                ),
                _buildActionButton(
                  icon: Icons.event_note,
                  title: "Events",
                  color: const Color(0xFFF56565),
                  onTap: () {
                    Navigator.pushNamed(context, '/events');
                  },
                ),
                _buildActionButton(
                  icon: Icons.payments_outlined,
                  title: "Payments",
                  color: const Color(0xFF4299E1),
                ),
                _buildActionButton(
                  icon: Icons.support_agent,
                  title: "Support",
                  color: const Color(0xFF0BC5EA),
                ),
                _buildActionButton(
                  icon: Icons.logout,
                  title: "Logout",
                  color: const Color(0xFF718096),
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text("Logged Out")));
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFB3E5FC), Color(0xFFFFF9C4)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Need help with something?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Post your request or find services from neighbors",
                    style: TextStyle(fontSize: 14, color: Color(0xFF718096)),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const TextField(
                            decoration: InputDecoration(
                              hintText: "What are you looking for?",
                              border: InputBorder.none,
                              icon: Icon(
                                Icons.search,
                                color: Color(0xFF667EEA),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF667EEA),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: const Icon(
                          Icons.filter_list,
                          color: Colors.white,
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
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String title,
    required Color color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: Colors.grey.shade100, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xFF4A5568),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// CATEGORY CHIP
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
                "Add Request",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),

              ListTile(
                leading: const Icon(Icons.people, color: Colors.blue),
                title: const Text("Guest Request"),
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
                leading: const Icon(Icons.delivery_dining, color: Colors.blue),
                title: const Text("Delivary Boy"),
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
                leading: const Icon(Icons.family_restroom, color: Colors.blue),
                title: const Text("Family Memeber"),
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
}
