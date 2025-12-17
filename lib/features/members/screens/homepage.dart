import 'package:flutter/material.dart';
import 'package:my_gate_clone/features/members/screens/complaints.dart';
import 'package:my_gate_clone/features/members/screens/emergency_alerts.dart';
import 'package:my_gate_clone/features/members/screens/events.dart';
import 'package:my_gate_clone/features/members/screens/guest_request.dart';
import 'package:my_gate_clone/features/members/screens/help_requestscreen.dart';
import 'package:my_gate_clone/features/members/screens/new_visitors.dart';
import 'package:my_gate_clone/features/members/screens/notice.dart';
import 'package:my_gate_clone/features/members/screens/notifications.dart';
import 'package:my_gate_clone/features/members/screens/service_providers.dart';
import 'package:my_gate_clone/features/members/screens/view_requests.dart';
import 'package:my_gate_clone/features/owner/modal/members_modal.dart';
import 'package:my_gate_clone/utilis/appbar.dart';

class MemberHomepage extends StatelessWidget {
  final MembersModal member;

  const MemberHomepage({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    // breakpoints
    final bool isTablet = width >= 600; // can tweak later [web:65]

    // layout values
    final int crossAxisCount = isTablet ? 4 : 3;
    final double childAspectRatio = isTablet ? 1.1 : 0.85;
    final EdgeInsets pagePadding = EdgeInsets.all(isTablet ? 24 : 16);
    final double headerAvatarRadius = isTablet ? 40 : 35;
    final double headerTextSize = isTablet ? 22 : 20;
    final double headerPadding = isTablet ? 24 : 20;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: reuseAppBar(
        title: "Member Dashboard",
        showBack: false,
        centerTittle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MemberNotificationsScreen(),
                ),
              );
            },
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // profile header
            GestureDetector(
              onTap: () => showMemberInfo(context),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF373B44), // dark indigo
                      Color(0xFF4286F4),
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
                  padding: EdgeInsets.all(headerPadding),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: headerAvatarRadius,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: headerAvatarRadius - 3,
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
                              style: TextStyle(
                                fontSize: headerTextSize,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Flat No: ${member.memberFlatNo}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
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
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2D3748),
              ),
            ),
            const SizedBox(height: 16),

            // responsive grid
            GridView.count(
              crossAxisCount: crossAxisCount,
              shrinkWrap: true,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio:
                  childAspectRatio, // key for tablet layout [web:5]
              children: [
                _buildActionButton(
                  icon: Icons.handshake_rounded,
                  title: "Quick Help",
                  color: const Color(0xFF667EEA),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HelpRequestListScreen(
                          currentMemberFlat: member.memberFlatNo,
                          currentMemberName: member.memberName,
                          currentMemberPhone: member.memberPhone,
                          societyId: member.societyId,
                          memberId: member.id,
                        ),
                      ),
                    );
                  },
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
                            GuestRequestListScreen(memberId: member.id),
                      ),
                    );
                  },
                ),
                _buildActionButton(
                  icon: Icons.list_alt,
                  title: "Services",
                  color: Colors.blue,
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
                  icon: Icons.door_back_door,
                  title: "Gate Requests",
                  color: Colors.brown,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MemberVisitorsScreen(memberId: member.id),
                      ),
                    );
                  },
                ),
                _buildActionButton(
                  icon: Icons.add_alert_sharp,
                  title: "Emergency Alerts",
                  color: Colors.red,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MemberEmergencyAlertsList(
                          societyId: member.societyId,
                        ),
                      ),
                    );
                  },
                ),
                _buildActionButton(
                  icon: Icons.currency_rupee_rounded,
                  title: "Payments",
                  color: const Color.fromARGB(255, 35, 153, 20),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddComplaintScreen(
                          memberId: member.id,
                          societyId: member.societyId,
                        ),
                      ),
                    );
                  },
                ),
                _buildActionButton(
                  icon: Icons.emergency,
                  title: "Complaints",
                  color: const Color(0xFF0BC5EA),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddComplaintScreen(
                          memberId: member.id,
                          societyId: member.societyId,
                        ),
                      ),
                    );
                  },
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
            const Divider(),
            const SizedBox(height: 20),

            EventsSection(member: member),
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
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF4A5568),
              ),
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
                infoCard("tower", member.tower),
                infoCard("Total Vehicles", member.totalVehicle),
                infoCard("Vehicle No", member.vehicleNo),

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
                      builder: (_) => GuestRequestScreen(
                        member: member,
                        defaultRequestType: 'Guest',
                      ),
                    ),
                  );
                },
              ),

              ListTile(
                leading: const Icon(Icons.delivery_dining, color: Colors.blue),
                title: const Text("Delivery Boy"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GuestRequestScreen(
                        member: member,
                        defaultRequestType: 'Delivery Boy',
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.family_restroom, color: Colors.blue),
                title: const Text("Family Member"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GuestRequestScreen(
                        member: member,
                        defaultRequestType: 'Family Member',
                      ),
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
