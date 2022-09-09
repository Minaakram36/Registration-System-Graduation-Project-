import 'package:flutter/material.dart';

import '../widgets/Database.dart';

class AddNewStudent extends StatefulWidget {
  const AddNewStudent({Key? key}) : super(key: key);

  @override
  State<AddNewStudent> createState() => _AddNewStudentState();
}

class _AddNewStudentState extends State<AddNewStudent> {
  final _IdController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _birthdateController = TextEditingController();
  final _phoneController = TextEditingController();
  final _genderController = TextEditingController();

  String get id => _IdController.text.trim();
  String get name => _nameController.text.trim();
  String get email => _emailController.text.trim();
  String get birthdate => _birthdateController.text.trim();
  String get phone => _phoneController.text.trim();
  String get gender => _genderController.text.trim();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add New Student",
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
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.person,
                                      color: Color.fromARGB(255, 44, 75, 143)),
                                  hintText: 'Enter Student Name ',
                                  labelText: 'Name',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Student Name';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _IdController,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.numbers,
                                      color: Color.fromARGB(255, 44, 75, 143)),
                                  hintText: 'Enter Student Id ',
                                  labelText: 'ID',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Student Id';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.email_outlined,
                                      color: Color.fromARGB(255, 44, 75, 143)),
                                  hintText: 'Enter Student Email ',
                                  labelText: 'Email',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Student Email';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _birthdateController,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.date_range,
                                      color: Color.fromARGB(255, 44, 75, 143)),
                                  hintText: 'Enter Student Birthday ',
                                  labelText: 'Birthday',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Student Birthday';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _phoneController,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.phone,
                                      color: Color.fromARGB(255, 44, 75, 143)),
                                  hintText: 'Enter Student Phone ',
                                  labelText: 'Phone',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Student Phone';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _genderController,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.list,
                                      color: Color.fromARGB(255, 44, 75, 143)),
                                  hintText: 'Enter Gender  ',
                                  labelText: 'Gender',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Gender';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Center(
                                child: Container(
                                  height: 50,
                                  width: 400,
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
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
                                    child: const Text('Submit'),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        createuseraccount(context, id, name,
                                            birthdate, gender, phone, email);
                                      }
                                      // print(_IdController.text);
                                      // print(_passwordController.text);
                                    },
                                  ),
                                ),
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
