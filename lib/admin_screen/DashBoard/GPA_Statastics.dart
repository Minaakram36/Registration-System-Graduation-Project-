import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:registrationsystem/admin_screen/DashBoard/GPA%20graterthan%20or%20equal%20to%203.7.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../screens v.2/profile.dart';
import '../pages/mobile/widgets/drawer_mobile.dart';
import 'GPA grater or equal 0 & lessthan 2.dart';
import 'GPA grater or equal 2 & lessthan 2.3.dart';
import 'GPA grater or equal 2.3 & lessthan 3 .dart';
import 'GPA grater or equal 3& lessthan 3.7.dart';

class GPA_Statastics extends StatelessWidget {
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
            title: Text("GPA Statistics"),
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
                                              GPAgraterorequal0andlessthan2()));
                                },
                                child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('Users')
                                        .where('GPA',
                                            isGreaterThanOrEqualTo: 0,
                                            isLessThan: 2.0)
                                        .snapshots(),
                                    builder: (ctx,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      }

                                      final docs = snapshot.data!.docs;
                                      return _singleItemQuickStats(
                                        title:
                                            "Students GPA equal to 0.0 and less than 2.0",
                                        value: docs.length.toString(),
                                        width:
                                            sizingInformation.screenSize.width /
                                                2.6,
                                        icon: Icons.abc,
                                        iconColor: Colors.white,
                                      );
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
                                              GPAgraterorequal2andlessthan2point3()));
                                },
                                child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('Users')
                                        .where('GPA',
                                            isGreaterThanOrEqualTo: 2.0,
                                            isLessThan: 2.3)
                                        .snapshots(),
                                    builder: (ctx,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      }

                                      final docs = snapshot.data!.docs;
                                      return _singleItemQuickStats(
                                        title:
                                            "Students GPA equal to 2.0 and less than 2.3",
                                        value: docs.length.toString(),
                                        width:
                                            sizingInformation.screenSize.width /
                                                2.6,
                                        icon: Icons.abc,
                                        iconColor: Colors.white,
                                      );
                                    }),
                              ),
                            ),
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
                                              GPAgraterorequal2point3andlessthan3()));
                                },
                                child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('Users')
                                        .where('GPA',
                                            isGreaterThanOrEqualTo: 2.3,
                                            isLessThan: 3.0)
                                        .snapshots(),
                                    builder: (ctx,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      }

                                      final docs = snapshot.data!.docs;
                                      return _singleItemQuickStats(
                                          title:
                                              "Students GPA equal to 2.3 and less than 3.0",
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
                                              GPAgraterorequal3andlessthan3point7()));
                                },
                                child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('Users')
                                        .where('GPA',
                                            isGreaterThanOrEqualTo: 3,
                                            isLessThan: 3.7)
                                        .snapshots(),
                                    builder: (ctx,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      }

                                      final docs = snapshot.data!.docs;
                                      return _singleItemQuickStats(
                                          title:
                                              "Students GPA equal to 3 and less than 3.7",
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
                                              GPAgraterthanorequalto3point7()));
                                },
                                child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('Users')
                                        .where('GPA',
                                            isGreaterThanOrEqualTo: 3.7)
                                        .snapshots(),
                                    builder: (ctx,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      }

                                      final docs = snapshot.data!.docs;
                                      return _singleItemQuickStats(
                                        title: " Students GPA from 3.7 to 4.0",
                                        value: docs.length.toString(),
                                        width:
                                            sizingInformation.screenSize.width /
                                                2.6,
                                        icon: Icons.abc,
                                        iconColor: Colors.white,
                                      );
                                    }),
                              ),
                            ),
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
      height: 125,
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
