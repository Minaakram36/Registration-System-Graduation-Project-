import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:registrationsystem/admin_screen/signin.dart';

class AdminAnnouncement extends StatefulWidget {
  const AdminAnnouncement({Key? key}) : super(key: key);
  @override
  State<AdminAnnouncement> createState() => _AdminAnnouncement();
}

class _AdminAnnouncement extends State<AdminAnnouncement> {
  TextEditingController Announcement = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String tdata = DateFormat("hh:mm:ss a").format(DateTime.now());
  String cdate2 = DateFormat("MMMM, dd, yyyy").format(DateTime.now());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: const Color.fromARGB(255, 44, 75, 143),
        title: Text("Announcement"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Announcements')
                    .orderBy('DateTime', descending: true)
                    .snapshots(),
                builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  final docs = snapshot.data!.docs;
                  return ListView.builder(
                      controller: ScrollController(),
                      itemCount: docs.length,
                      itemBuilder: (ctx, index) {
                        return  Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 44, 75, 143),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${docs[index]['Name']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '${docs[index]['Time']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '${docs[index]['Date']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(height: 5),
                                    const Icon(
                                      Icons.alarm,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 100,
                                  width: 1,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          160,
                                      child: Text(
                                        '${docs[index]['Text']}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                      });
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    minLines: 6,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: Announcement,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.announcement,
                          color: Color.fromARGB(255, 44, 75, 143)),
                      hintText: 'Type Announcement ',
                      labelText: 'Announcement',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field can not be empty';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(),
              IconButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FirebaseFirestore.instance
                          .collection('Announcements')
                          .add({
                        'Text': Announcement.text.trim(),
                        'Time': tdata,
                        'Date': cdate2,
                        'DateTime':DateTime.now(),
                        'Name':adminname,
                      });
                    }
                    Announcement.clear();
                  },
                  icon: const Icon(Icons.arrow_circle_right_rounded)),
            ],
          )
        ],
      ),
    );
  }
}
