import 'package:flutter/material.dart';
import 'package:my_gate_clone/features/owner/provider/notice.dart';
import 'package:my_gate_clone/utilis/appbar.dart';
import 'package:provider/provider.dart';

class Notice extends StatefulWidget {
  final int socityId;
  const Notice({super.key, required this.socityId});

  @override
  State<Notice> createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  TextEditingController noticeCRTL = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<NoticeProvider>(
      context,
      listen: false,
    ).getNotices(widget.socityId);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NoticeProvider>(context);

    return Scaffold(
      appBar: reuseAppBar(title: 'Notice Board'),
      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create New Notice",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),

              Card(
                color: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        controller: noticeCRTL,
                        maxLines: 5,
                        decoration: InputDecoration(
                          label: Text("Write your notice..."),
                          hintText: "Example: Water supply off at 3 PM.",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      /// ADD BUTTON
                      GestureDetector(
                        onTap: () async {
                          if (noticeCRTL.text.trim().isEmpty) return;

                          await provider.addNotice(
                            societyId: widget.socityId,
                            notice: noticeCRTL.text.trim(),
                          );

                          noticeCRTL.clear();

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Notice Added Successfully"),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue.shade500,
                                Colors.blue.shade700,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "Add Notice",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 25),

              Text(
                "Recent Notices",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 15),

              /// NOTICE LIST
              if (provider.isLoading)
                Center(child: CircularProgressIndicator())
              else if (provider.notices.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      "No notices found.\nAdd your first notice!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: provider.notices.length,
                  itemBuilder: (context, index) {
                    final n = provider.notices[index];

                    return Card(
                      color: Colors.white,
                      elevation: 3,
                      margin: EdgeInsets.only(bottom: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              n['notice'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            SizedBox(height: 10),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                /// UPDATE BUTTON
                                TextButton(
                                  onPressed: () {
                                    _showUpdateDialog(context, n, provider);
                                  },
                                  child: Text(
                                    "Update",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),

                                /// DELETE BUTTON
                                TextButton(
                                  onPressed: () async {
                                    await provider.deleteNotice(
                                      n['id'],
                                      widget.socityId,
                                    );
                                  },
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// ---------------------------------------------
  /// UPDATE NOTICE DIALOG
  /// ---------------------------------------------
  void _showUpdateDialog(
    context,
    Map<String, dynamic> notice,
    NoticeProvider provider,
  ) {
    TextEditingController updateCtrl = TextEditingController(
      text: notice['notice'],
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update Notice"),
          content: TextField(
            controller: updateCtrl,
            maxLines: 4,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await provider.updateNotice(
                  noticeId: notice['id'],
                  noticeText: updateCtrl.text.trim(),
                  societyId: widget.socityId,
                );

                Navigator.pop(context);
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }
}
