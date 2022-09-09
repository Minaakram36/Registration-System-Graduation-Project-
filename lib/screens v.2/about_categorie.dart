import 'package:flutter/material.dart';

class about_categorie extends StatelessWidget {


  final String classTopic;
  final String course_code;
  final String course_credit_hours;

  final String pre_requiste;

  about_categorie(
      {
      required this.classTopic,
      required this.course_code,
      required this.course_credit_hours,
      required this.pre_requiste});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: Table(
              border: TableBorder.all(
                width: 2,
              ),
              children: [
                TableRow(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(212, 226, 232, 236),
                    ),
                    children: [
                      Center(
                          child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(classTopic,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      )),
                      Center(
                          child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(course_code,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      )),
                      Center(
                          child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(course_credit_hours,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      )),
                      Center(
                          child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(pre_requiste,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      )),
                    ]),
              ],
            ),
          ),
        ]));
  }
}
