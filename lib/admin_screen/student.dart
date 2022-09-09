import 'package:registrationsystem/admin_screen/Add_New_Student.dart';
import 'package:registrationsystem/admin_screen/profile_SearchStudent.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'pages/mobile/widgets/drawer_mobile.dart';

class student extends StatefulWidget {
  const student({Key? key}) : super(key: key);

  @override
  State<student> createState() => _student();
}

class _student extends State<student> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (_, sizingInformation) {
      return Scaffold(
        key: scaffoldKey,
        drawer: DrawerMobile(),
        appBar: AppBar(
          title: const Text(
            "Manage Students",
            style: TextStyle(fontSize: 24),
          ),
          backgroundColor: const Color.fromARGB(255, 44, 75, 143),
          leading: GestureDetector(
              onTap: () {
                scaffoldKey.currentState?.openDrawer();
              },
              child: Icon(Icons.menu)),
        ),
        body: SafeArea(
            child: Column(children: <Widget>[
          Expanded(
              child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: const Center(child: const Text('Student Information')),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const psearchstudent()));
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey),
                  textStyle:
                      MaterialStateProperty.all(const TextStyle(fontSize: 30))),
            ),
          )),
          Expanded(
              child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: const Center(child: Text('Add New Student')),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddNewStudent()));
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(250, 243, 132, 72)),
                  textStyle:
                      MaterialStateProperty.all(const TextStyle(fontSize: 30))),
            ),
          )),
        ])),
      );
    });
  }
}
