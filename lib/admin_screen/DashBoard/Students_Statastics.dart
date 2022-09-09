import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:registrationsystem/admin_screen/DashBoard/all_levelonestudent.dart';
import 'package:registrationsystem/admin_screen/DashBoard/all_levelthreestudent.dart';
import 'package:registrationsystem/admin_screen/DashBoard/studentlevel4.dart';
import 'package:registrationsystem/admin_screen/pages/mobile/widgets/drawer_mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../screens v.2/profile.dart';
import 'GPA_Statastics.dart';
import 'all_leveltwostudent.dart';

class Students_Statastics extends StatelessWidget {
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
            title: Text("Students Statisitcs"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              all_levelonestudent()));
                                },
                                child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('Users')
                                        .where('List', isEqualTo: '421')
                                        .snapshots(),
                                    builder: (ctx,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      }

                                      final docs = snapshot.data!.docs;
                                      return _singleItemQuickStats(
                                          title: "Level 1- Students",
                                          value: docs.length.toString(),
                                          icon: Icons.abc,
                                          width: sizingInformation
                                                  .screenSize.width /
                                              2.6,
                                          textColor: Colors.red,
                                          iconColor: Colors.white);
                                    }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              all_leveltwostudent()));
                                },
                                child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('Users')
                                        .where('List', isEqualTo: '420')
                                        .snapshots(),
                                    builder: (ctx,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      }

                                      final docs = snapshot.data!.docs;
                                      return _singleItemQuickStats(
                                          title: "Level 2- Students",
                                          value: docs.length.toString(),
                                          icon: Icons.abc,
                                          width: sizingInformation
                                                  .screenSize.width /
                                              2.6,
                                          textColor: Colors.red,
                                          iconColor: Colors.white);
                                    }),
                              ),
                            )
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              all_levelthreestudent()));
                                },
                                child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('Users')
                                        .where('List', isEqualTo: '419')
                                        .snapshots(),
                                    builder: (ctx,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      }

                                      final docs = snapshot.data!.docs;
                                      return _singleItemQuickStats(
                                          title: "Level 3- Students",
                                          value: docs.length.toString(),
                                          icon: Icons.abc,
                                          width: sizingInformation
                                                  .screenSize.width /
                                              2.6,
                                          textColor: Colors.red,
                                          iconColor: Colors.white);
                                    }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              studentlevel4()));
                                },
                                child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('Users')
                                        .where('List', isEqualTo: '418')
                                        .snapshots(),
                                    builder: (ctx,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      }

                                      final docs = snapshot.data!.docs;
                                      return _singleItemQuickStats(
                                          title: "Level 4- Students",
                                          value: docs.length.toString(),
                                          icon: Icons.abc,
                                          width: sizingInformation
                                                  .screenSize.width /
                                              2.6,
                                          textColor: Colors.red,
                                          iconColor: Colors.white);
                                    }),
                              ),
                            )
                          ]),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _singleItemQuickStats(
      {required String title,
      Color textColor = Colors.black,
      required String value,
      required IconData icon,
      required double width,
      required Color iconColor}) {
    return Container(
      width: width,
      height: 110,
      padding: EdgeInsets.symmetric(horizontal: 28, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(.2),
              spreadRadius: 2,
              offset: Offset(0.5, 0.5),
              blurRadius: 2),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(color: textColor, fontSize: 14),
          ),
          SizedBox(
            height: 10,
          ),
          icon == null
              ? Text(
                  value,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      icon,
                      color: iconColor,
                    )
                  ],
                ),
        ],
      ),
    );
  }
}
