import 'package:flutter/material.dart';


class completed_categorie extends StatelessWidget {
  final String classTopic;
  final String course_credit_hours;

  final String course_code;
  final String professor;
  final String course_grade;

  completed_categorie({
    required this.classTopic,
    required this.course_credit_hours,
    required this.course_code,
    required this.professor,
    required this.course_grade,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: new EdgeInsets.symmetric(vertical: 20.0),
      color: Colors.lightGreen,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: Icon(
                  Icons.menu_book,
                  color: Color.fromRGBO(51, 98, 204, 1),
                  size: 28,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                children: <Widget>[
                  Container(
                    width: 240,
                    child: Text(
                      classTopic,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w200,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  Container(
                    width: 240,
                    child: Text(
                      '$course_credit_hours ch',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Course Code',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 20,
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      child: Text(
                        course_code,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Professor/Teacher',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Container(
                    width: 190,
                    height: 20,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      professor,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w200,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 132,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            alignment: Alignment.center,
            child: course_grade != 'F'
                ? Text(
              'Grade : $course_grade',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w200,
                letterSpacing: 1.0,
              ),
            )
                : Text(
              'Grade : $course_grade',
              style: TextStyle(
                color: Colors.red,
                fontSize: 14,
                fontWeight: FontWeight.w200,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}