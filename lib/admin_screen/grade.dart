import 'package:flutter/material.dart';
import 'package:registrationsystem/widgets/Database.dart';

import 'AssignGrade.dart';
import 'pages/mobile/widgets/drawer_mobile.dart';

class grade extends StatefulWidget {
  String studentid;
  String studentname;

  grade(this.studentid, this.studentname, {Key? key}) : super(key: key);
  @override
  State<grade> createState() => _grade();
}

class _grade extends State<grade> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerMobile(),
      appBar: AppBar(
        title: Text(
          widget.studentname + " Grades",
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
            child: const Center(child: const Text('Assign Grades')),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => addstudentgrade(
                          widget.studentid, widget.studentname)));
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
            child: const Center(child: Text('Update GPA and Total hours')),
            onPressed: () {
              showDialog(

                  context: context,
                  builder: (context2) =>AlertDialog(
                    title: Text("Update User Information"),
                    content: Text("Would you like to Update student GPA ,TotalHours and clear inprogress Courses"),

                    actions: [
                      TextButton(
                        child: Text("Continue"),
                        onPressed:  () {
                          movecoursestodoneorfail(context,widget.studentid);
                          Navigator.pop(context2);
                        },
                      )

                    ],
                  )
              );
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(250, 243, 132, 72)),
                textStyle:
                    MaterialStateProperty.all(const TextStyle(fontSize: 30))),
          ),
        ))
      ])),
    );
  }
}
