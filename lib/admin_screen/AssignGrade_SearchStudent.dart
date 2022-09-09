import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'AssignGrade.dart';
import 'grade.dart';

class searchstudent extends StatefulWidget {
  const searchstudent({Key? key}) : super(key: key);

  @override
  State<searchstudent> createState() => _searchstudent();
}

class _searchstudent extends State<searchstudent> {
  final _IdController = TextEditingController();
  String get idcontroller => _IdController.text.trim();
  final _formKey = GlobalKey<FormState>();
  bool isloading = false;
  //---------------------------Functions----------------------------------------
  void searchuserexist(String userid) async {
    try {
      setState(() {
        isloading = true;
      });
      var result = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userid)
          .get();
      if (result.exists) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => grade(
                      userid,
                      result['Name'],
                    )));

        setState(() {
          isloading = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('This ID does not exist!'),
        ));
        setState(() {
          isloading = false;
        });
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('This ID does not exist!'),
      ));
      setState(() {
        isloading = false;
      });
    }
  }
  //----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Manage Student Grades",
          style: TextStyle(fontSize: 24),
        ),
        backgroundColor: const Color.fromARGB(255, 44, 75, 143),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.02,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextFormField(
                                controller: _IdController,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.numbers,
                                      color: Color.fromARGB(255, 44, 75, 143)),
                                  hintText: 'Enter Student Id ',
                                  labelText: 'Student ID',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Student Id';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Center(
                                child: !isloading
                                    ? Container(
                                        height: 50,
                                        width: 400,
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    const Color.fromARGB(
                                                        255, 44, 75, 143)),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                side: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 44, 75, 143),
                                                ),
                                              ),
                                            ),
                                          ),
                                          child: const Text('Next'),
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              searchuserexist(idcontroller);
                                            }
                                          },
                                        ),
                                      )
                                    : CircularProgressIndicator(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
