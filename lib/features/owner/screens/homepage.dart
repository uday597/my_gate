import 'package:flutter/material.dart';
import 'package:my_gate_clone/features/admin/modal/society.dart';
import 'package:my_gate_clone/features/owner/screens/add_members.dart';
import 'package:my_gate_clone/features/owner/screens/add_securityGuard.dart';
import 'package:my_gate_clone/features/owner/screens/guard_list.dart';
import 'package:my_gate_clone/features/owner/screens/members_list.dart';
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
      {
        'title': 'Add Members',
        'icon': Icons.group_add,
        'screen': AddMembers(ownerID: widget.owner.id),
      },
      {
        'title': 'Add Security',
        'icon': Icons.security,
        'screen': AddSecurityGuard(societyId: widget.owner.id),
      },
      {
        'title': 'View Members',
        'icon': Icons.group,
        'screen': MembersListScreen(),
      },
      {
        'title': 'View Guards',
        'icon': Icons.shield_outlined,
        'screen': GuardsList(societyId: widget.owner.id),
      },
    ];

    return Scaffold(
      appBar: reuseAppBar(title: 'Owner Home'),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // Society Banner
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 10,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFB3E5FC), Color(0xFFFFF9C4)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Text(
                              widget.owner.societyName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Owner Info
                          Row(
                            children: [
                              const Icon(
                                Icons.person,
                                color: Color(0xFFB3E5FC),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text("Owner: ${widget.owner.ownerName}"),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.phone, color: Color(0xFFB3E5FC)),
                              const SizedBox(width: 8),
                              Expanded(child: Text(widget.owner.ownerPhone)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.email, color: Color(0xFFB3E5FC)),
                              const SizedBox(width: 8),
                              Expanded(child: Text(widget.owner.ownerEmail)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Color(0xFFB3E5FC),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(widget.owner.societyAddress),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Close button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                              child: const Text(
                                "Close",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFB3E5FC),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.owner.societyName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.owner.societyAddress,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Owner: ${widget.owner.ownerName}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              "Features",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: features.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    featureBox(
                      icon: features[index]['icon'],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => features[index]['screen'],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      features[index]['title'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Feature Box
Widget featureBox({
  required IconData icon,
  required VoidCallback onTap,
  Color? color,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, // white card
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          icon,
          size: 28,
          color: color ?? Colors.blueAccent, // colorful icons
        ),
      ),
    ),
  );
}
