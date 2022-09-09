import 'package:registrationsystem/admin_screen/completed.dart';
import 'package:registrationsystem/admin_screen/fail.dart';
import 'package:registrationsystem/admin_screen/inprogress.dart';
import 'package:flutter/material.dart';

import 'Registration_page2.dart';
import 'pages/mobile/widgets/drawer_mobile.dart';

class course extends StatefulWidget {
  String list;
  String studentid;
  String studentname;

  course(this.studentid, this.list, this.studentname, {Key? key})
      : super(key: key);

  @override
  State<course> createState() => _course();
}

class _course extends State<course> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerMobile(),
      appBar: AppBar(
        title: Text(
          widget.studentname + " Courses",
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
            child: const Center(child:  Text('Assign Courses')),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => choosecourses(widget.studentid,widget.studentname)));
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
            child: const Center(child: const Text('inprogress Courses')),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          inprogress(widget.studentid, widget.studentname)));
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                textStyle:
                    MaterialStateProperty.all(const TextStyle(fontSize: 30))),
          ),
        )),
        Expanded(
            child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            child: const Center(child: Text('completed Courses')),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          completed(widget.studentid, widget.studentname)));
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.lightGreen),
                textStyle:
                    MaterialStateProperty.all(const TextStyle(fontSize: 30))),
          ),
        )),
        Expanded(
            child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            child: const Center(child: Text('Failed Courses')),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          fail(widget.studentid, widget.studentname)));
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                textStyle:
                    MaterialStateProperty.all(const TextStyle(fontSize: 30))),
          ),
        )),
      ])),
    );
  }
}
