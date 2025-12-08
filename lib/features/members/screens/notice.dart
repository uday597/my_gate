import 'package:flutter/material.dart';
import 'package:my_gate_clone/features/owner/provider/notice.dart';
import 'package:my_gate_clone/utilis/appbar.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class MemberNoticeList extends StatefulWidget {
  final int societyId;

  const MemberNoticeList({super.key, required this.societyId});

  @override
  State<MemberNoticeList> createState() => _MemberNoticeListState();
}

class _MemberNoticeListState extends State<MemberNoticeList> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoticeProvider>(
      context,
      listen: false,
    ).getNotices(widget.societyId);
  }

  String formatDate(String date) {
    final d = DateTime.parse(date);
    return DateFormat('dd MMM, yyyy • hh:mm a').format(d);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NoticeProvider>(context);

    return Scaffold(
      appBar: reuseAppBar(title: "Notices"),
      backgroundColor: Colors.grey.shade100,

      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : provider.notices.isEmpty
          ? Center(
              child: Text(
                "No notices available",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: provider.notices.length,
                itemBuilder: (context, index) {
                  final n = provider.notices[index];

                  return Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade50, Colors.white],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Highlight Bar
                        Container(
                          width: 6,
                          height: 110,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(18),
                              bottomLeft: Radius.circular(18),
                            ),
                          ),
                        ),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title Row
                                Row(
                                  children: [
                                    Icon(
                                      Icons.campaign,
                                      color: Colors.blue,
                                      size: 22,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      "Notice",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue.shade700,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 8),

                                // Notice Text
                                Text(
                                  n['notice'],
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black87,
                                  ),
                                ),

                                SizedBox(height: 10),

                                // Date
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      formatDate(n['created_at']),
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
