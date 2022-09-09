import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:registrationsystem/admin_screen/DashBoard/GPA_Statastics.dart';
import 'package:registrationsystem/admin_screen/DashBoard/Students_Statastics.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../screens v.2/profile.dart';
import 'widgets/drawer_mobile.dart';

class MobileScreen extends StatelessWidget {
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
            title: Text("Dashboard"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin:
                      EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      color: Color.fromARGB(255, 44, 75, 143)),
                  child: Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Statisitcs",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            WidgetSpan(
                              child: Icon(
                                Icons.bar_chart,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
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
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('Users')
                                    .snapshots(),
                                builder: (ctx,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  }

                                  final docs = snapshot.data!.docs;
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Students_Statastics()));
                                    },
                                    child: _singleItemQuickStats(
                                      title: "Students",
                                      value: docs.length.toString(),
                                      width:
                                          sizingInformation.screenSize.width /
                                              2.6,
                                      icon: Icons.abc,
                                      iconColor: Colors.white,
                                    ),
                                  );
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            GPA_Statastics()));
                              },
                              child: _singleItemQuickStats(
                                  title: "GPA",
                                  value: 'Ranges',
                                  icon: Icons.abc,
                                  width:
                                      sizingInformation.screenSize.width / 2.6,
                                  textColor: Colors.red,
                                  iconColor: Colors.white),
                            ),
                          )
                        ],
                      ),
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
