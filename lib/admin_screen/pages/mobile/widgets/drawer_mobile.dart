import 'package:registrationsystem/admin_screen/Admin_announcemennt.dart';
import 'package:registrationsystem/admin_screen/AssignGrade_SearchStudent.dart';
import 'package:registrationsystem/admin_screen/Jsontest.dart';
import 'package:registrationsystem/admin_screen/signin.dart';
import 'package:registrationsystem/admin_screen/student.dart';
import 'package:flutter/material.dart';
import 'package:registrationsystem/admin_screen/Registration_SearchStudent.dart';
import '../mobile_screen.dart';

class DrawerMobile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.2),
          blurRadius: 2,
          offset: const Offset(0.5, 0.0),
          spreadRadius: 2,
        ),
      ]),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MobileScreen()));
              },
              child: _singleButton(icon: Icons.score, title: "Dashboard")),
          const Divider(
            thickness: 1,
          ),
          const SizedBox(
            height: 50,
          ),
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const student()));
              },
              child: _singleButton(
                  icon: Icons.people_alt_rounded, title: "Students")),
          const Divider(
            thickness: 1,
          ),
          const SizedBox(
            height: 50,
          ),
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const rsearchstudent()));
              },
              child: _singleButton(
                  icon: Icons.my_library_books_sharp, title: "Courses")),
          const SizedBox(
            height: 50,
          ),
          const Divider(
            thickness: 1,
          ),
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const searchstudent()));
              },
              child: _singleButton(
                  icon: Icons.assignment_turned_in_outlined, title: "Grades")),
          const SizedBox(
            height: 50,
          ),
          const Divider(
            thickness: 1,
          ),
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminAnnouncement()));
              },
              child: _singleButton(
                  icon: Icons.announcement, title: "Announcement")),
          const SizedBox(
            height: 50,
          ),
          const Divider(
            thickness: 1,
          ),
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const jsontest()));
              },
              child: _singleButton(
                  icon: Icons.update, title: "Soon")),
          const SizedBox(
            height: 50,
          ),
          const Divider(
            thickness: 1,
          ),
          InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const adminsignin()));
              },
              child: _singleButton(icon: Icons.exit_to_app, title: "Sign out")),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  Widget _singleButton({required IconData icon, required String title}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Icon(icon),
          Text(
            title,
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }
}
