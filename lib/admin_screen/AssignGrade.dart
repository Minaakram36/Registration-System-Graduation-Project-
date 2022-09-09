import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/Database.dart';

class addstudentgrade extends StatefulWidget {
  String studentid;
  String studentname;

  addstudentgrade(this.studentid, this.studentname, {Key? key})
      : super(key: key);

  @override
  State<addstudentgrade> createState() => _addstudentgradeState();
}

final _grades = [
  '',
  'A',
  'A-',
  'B+',
  'B',
  'B-',
  'C+',
  'C',
  'C-',
  'D+',
  'D',
  'F'
];

List<TextEditingController> Textfieldscontrollers = [];
List<String> subjectcode = [];
int doclength = 0;

class _addstudentgradeState extends State<addstudentgrade> {
  @override
  void initState() {
    super.initState();
    Textfieldscontrollers.clear();
    subjectcode.clear();
    Textfieldscontrollers = [];
    subjectcode = [];
    doclength = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.studentname,
          style: TextStyle(fontSize: 24),
        ),
        backgroundColor: const Color.fromARGB(255, 44, 75, 143),
      ),
      body: Column(
        children: [
          Flexible(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(widget.studentid)
                  .collection('Courses')
                  .snapshots(),
              builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final docs = snapshot.data!.docs;
                doclength = docs.length;
                //docs.forEach((element) {x.add(element['Credithoure']);});
                // print(x);

                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (ctx, index) {
                    Textfieldscontrollers.add(TextEditingController());
                    subjectcode.add(docs[index].id.toString());

                    return Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Courses(
                              context,
                              widget.studentid,
                              docs[index]['Name'],
                              docs[index]['Credithoure'].toString(),
                              docs[index].id,
                              Textfieldscontrollers[index])
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Center(
            child: Container(
              height: 50,
              width: 400,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 44, 75, 143)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        side: BorderSide(
                          color: Color.fromARGB(255, 44, 75, 143),
                        ),
                      ),
                    ),
                  ),
                  child: const Text('submit'),
                  onPressed: () {
                    /* for (int i = 0; i < doclength; i++) {
                      if (_grades.contains(
                          Textfieldscontrollers[i].text.trim().toUpperCase())) {
                        addgrade(context, widget.studentid, subjectcode[i],
                            Textfieldscontrollers[i].text.trim().toUpperCase());
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          '${Textfieldscontrollers[i].text.trim().toUpperCase()} is invalid!!!',
                          style: TextStyle(color: Colors.red),
                        )));
                      }
                    }

                    calculatesemestergpa(context, widget.studentid);*/
                    addmultiplegrade(context, widget.studentid, subjectcode,
                        Textfieldscontrollers, doclength);
                  }),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

Widget Courses(context, String studentid, String classTopic,
    String course_credit_hours, String course_code, Textfieldscontrollers) {
  TextEditingController grade = Textfieldscontrollers;

  return Column(
    children: <Widget>[
      Table(
        children: const [
          TableRow(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              children: [
                Center(
                  child: Text(
                    'Course Name',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Center(
                  child: Text(
                    'Course Code',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Center(
                  child: Text(
                    'Credit hours',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Center(
                    child: Text(
                      'Grade',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )),
                Center(
                    child: Text(
                      '',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ))
              ]),
        ],
      ),
      SingleChildScrollView(
        child: Center(
            child: Table(
              children: [
                TableRow(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(212, 226, 232, 236),
                    ),
                    children: [
                      Text(classTopic,
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      Center(
                        child: Text(course_code,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                      Center(
                          child: Center(
                            child: Text(course_credit_hours,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12)),
                          )),
                      Center(
                          child: Center(
                            child: TextField(
                              controller: grade,
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          )),
                      Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 44, 75, 143)),
                            shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(
                                  color: Color.fromARGB(255, 44, 75, 143),
                                ),
                              ),
                            ),
                          ),
                          child: const Icon(
                            Icons.save,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (_grades.contains(grade.text.trim().toUpperCase())) {
                              addgrade(context, studentid, course_code,
                                  grade.text.trim().toUpperCase());
                              calculatesemestergpa(context, studentid);
                            }
                            //Textfieldscontrollers.clear();
                            else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                    '${grade.text.trim().toUpperCase()} is invalid!!!',
                                    style: TextStyle(color: Colors.red),
                                  )));
                            }
                          },
                        ),
                      )
                    ]),
              ],
            )),
      )
    ],
  );
}
