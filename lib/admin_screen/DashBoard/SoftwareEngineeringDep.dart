import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:registrationsystem/admin_screen/pages/mobile/widgets/drawer_mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../screens v.2/profile.dart';

import 'GPA_Statastics.dart';

class SoftwareEngineeringDep extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (_, sizingInformation) {
        return Scaffold(
          backgroundColor: Color.fromARGB(255, 190, 200, 219),
          key: scaffoldKey,
          drawer: DrawerMobile(),
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 44, 75, 143),
            leading: GestureDetector(
                onTap: () {
                  scaffoldKey.currentState?.openDrawer();
                },
                child: Icon(Icons.menu)),
            title: Text("Software Engineering Students"),
          ),
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .where('Department', isEqualTo: 'Software Engineering')
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
                            return Card(
                                child: ListTile(
                              title: Text('Name: ${docs[index]['Name']}'),
                              subtitle: Text('ID:' + docs[index].id.toString()),
                              trailing:
                                  Text('Level 4 - Software Engineering Major'),
                            ));
                          });
                    }),
              ),
            ],
          ),
        );
      },
    );
  }
}
