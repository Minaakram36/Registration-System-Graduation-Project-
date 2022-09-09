import 'package:registrationsystem/widgets/Database.dart';
import 'package:flutter/material.dart';

import 'Registration_page2.dart';

class coursesregistration extends StatefulWidget {
  String studentname;
  String studentid;
  double gpa;
  String list;
  int Totalhours;
  int passedhours;

  coursesregistration(this.studentname, this.studentid, this.gpa, this.list,
      this.Totalhours, this.passedhours,
      {Key? key})
      : super(key: key);

  @override
  State<coursesregistration> createState() => _coursesregistrationState();
}

class _coursesregistrationState extends State<coursesregistration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Assign Courses",
            style: TextStyle(fontSize: 24),
          ),
          backgroundColor: const Color.fromARGB(255, 44, 75, 143),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name : ${widget.studentname}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Text('ID : ${widget.studentid}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(
                height: 20,
              ),
              Text('GPA : ${widget.gpa}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(
                height: 20,
              ),
              Text('Total Hours : ${widget.Totalhours}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(
                height: 20,
              ),
              Text('Passed Hours : ${widget.passedhours}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Center(
                  child: Container(
                    alignment: AlignmentDirectional.bottomCenter,
                    height: 100,
                    width: 400,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 44, 75, 143)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(
                                  color: Color.fromARGB(255, 44, 75, 143),
                                ),
                              ),
                            ),
                          ),
                          child: const Text('Add Courses'),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => choosecourses(
                                        widget.studentid,

                                        widget.studentname)));
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FittedBox(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 44, 75, 143)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  side: BorderSide(
                                    color: Color.fromARGB(255, 44, 75, 143),
                                  ),
                                ),
                              ),
                            ),
                            child: const Text('Make Sure Grades'),
                            onPressed: () {
                              movecoursestodoneorfail(context,widget.studentid);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
