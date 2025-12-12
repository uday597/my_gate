import 'package:flutter/material.dart';
import 'package:my_gate_clone/features/admin/modal/society.dart';
import 'package:my_gate_clone/features/owner/screens/add_members.dart';
import 'package:my_gate_clone/features/owner/screens/add_securityGuard.dart';
import 'package:my_gate_clone/features/owner/screens/complaints.dart';
import 'package:my_gate_clone/features/owner/screens/guard_list.dart';
import 'package:my_gate_clone/features/owner/screens/members_list.dart';
import 'package:my_gate_clone/features/owner/screens/notice.dart';
import 'package:my_gate_clone/features/owner/screens/service_provider.dart';
import 'package:my_gate_clone/utilis/appbar.dart';

class OwnerHomepage extends StatefulWidget {
  final SocietyModal owner;
  const OwnerHomepage({super.key, required this.owner});

  @override
  State<OwnerHomepage> createState() => _OwnerHomepageState();
}

class _OwnerHomepageState extends State<OwnerHomepage> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> features = [
      //owner id basically society id hi hai
      {
        'title': 'Add Members',
        'icon': Icons.group_add,
        'screen': AddMembers(ownerID: widget.owner.id),
        'color': const Color(0xFF667EEA),
      },
      {
        'title': 'Add Security',
        'icon': Icons.security,
        'screen': AddSecurityGuard(societyId: widget.owner.id),
        'color': const Color(0xFF48BB78),
      },
      {
        'title': 'Add Services',
        'icon': Icons.design_services,
        'screen': ProvidersListScreen(societyId: widget.owner.id),
        'color': const Color(0xFFED8936),
      },
      {
        'title': 'View Guards',
        'icon': Icons.shield_outlined,
        'screen': GuardsList(societyId: widget.owner.id),
        'color': const Color(0xFFF56565),
      },
      {
        'title': 'View Members',
        'icon': Icons.group,
        'screen': MembersListScreen(societyId: widget.owner.id),
        'color': const Color(0xFF4299E1),
      },
      {
        'title': 'Notice',
        'icon': Icons.notifications,
        'screen': Notice(socityId: widget.owner.id),
        'color': const Color(0xFF9F7AEA),
      },
      {
        'title': 'Payments',
        'icon': Icons.payments,
        'screen': Notice(socityId: widget.owner.id),
        'color': Colors.yellow,
      },
      {
        'title': 'Complaints',
        'icon': Icons.edit_document,
        'screen': ComplaintsRequests(socityId: widget.owner.id),
        'color': Colors.teal,
      },
      {
        'title': 'Emergency Alerts',
        'icon': Icons.add_alert,
        'screen': Notice(socityId: widget.owner.id),
        'color': Colors.red,
      },
    ];

    return Scaffold(
      appBar: reuseAppBar(
        title: "Owner Dashboard",
        showBack: false,
        centerTittle: true,
      ),
      backgroundColor: const Color(0xFFF8F9FA),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => showOwnerInfo(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFB3E5FC), Color(0xFFFFF9C4)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF667EEA).withOpacity(0.25),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: const Icon(
                        Icons.apartment,
                        size: 35,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.owner.ownerName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.owner.societyName,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 6),
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
                              "Society Owner",
                              style: TextStyle(
                                fontSize: 12,
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

            GridView.builder(
              itemCount: features.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (context, index) {
                final item = features[index];

                return _buildActionButton(
                  icon: item['icon'],
                  title: item['title'],
                  color: item['color'],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => item['screen']),
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 20),
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
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.12),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 26, color: color),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xFF4A5568),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void showOwnerInfo() {
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
                width: 60,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 16),
              const Icon(Icons.person, size: 70, color: Colors.blueAccent),
              const SizedBox(height: 12),

              Text(
                widget.owner.ownerName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),
              infoTile("Society", widget.owner.societyName),
              infoTile("Phone", widget.owner.ownerPhone),
              infoTile("Email", widget.owner.ownerEmail),
              infoTile("Address", widget.owner.societyAddress),
            ],
          ),
        );
      },
    );
  }

  Widget infoTile(String title, String value) {
    return Card(
      color: Colors.white,
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
}
