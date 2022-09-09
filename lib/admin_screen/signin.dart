import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:registrationsystem/screens v.2/signin.dart';

import 'AdminHomeScreen.dart';
String? adminname;
class adminsignin extends StatefulWidget {
  const adminsignin({Key? key}) : super(key: key);

  @override
  State<adminsignin> createState() => _adminsignin();
}

class _adminsignin extends State<adminsignin> {
  final _IdController = TextEditingController();
  final _passwordController = TextEditingController();

  String get Id => _IdController.text.trim();
  String get password => _passwordController.text.trim();
  final _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;
  bool isloading=false;
  //---------------------------functions---------------------------------------
  void adminLogin(String id, String password) async {
    String errormsg = "";
    try {
      setState(() {
        isloading = true;
      });
      var result =
      await FirebaseFirestore.instance.collection('Admin').doc(id).get();
      if (result['Password'] == password) {
        adminname = result['Name'];
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => AdminHomeScreen()));
        setState(() {
          isloading = false;
        });
      } else {
        errormsg = 'Incorrect ID or Password';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errormsg),
        ));
        setState(() {
          isloading = false;
        });
      }
    } catch (error) {
      errormsg = 'Incorrect ID or Password';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errormsg),
      ));
      setState(() {
        isloading = false;
      });
    }
  }
  //---------------------------functions---------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Log In",
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
                        Container(
                          height: 170,
                          width: MediaQuery.of(context).size.width * 0.8,
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.09),
                          child: Image.asset("assets/images/img2.jpg"),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextFormField(
                                controller: _IdController,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.person,
                                      color: Color.fromARGB(255, 44, 75, 143)),
                                  hintText: 'Enter your name ',
                                  labelText: 'Name',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _passwordController,
                                obscureText: !_passwordVisible,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  hintText: 'Enter your password',
                                  icon: const Icon(
                                    Icons.password_outlined,
                                    color: Color.fromARGB(255, 44, 75, 143),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: const Color.fromARGB(
                                          255, 44, 75, 143),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Signin()));
                                  },
                                  child: const Text(
                                    'Student login ',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 44, 75, 143),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Center(
                                child:!isloading? Container(
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
                                    child: const Text('Sign in'),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        adminLogin(Id, password);
                                      }
                                      // print(_IdController.text);
                                      // print(_passwordController.text);
                                    },
                                  ),
                                ):CircularProgressIndicator(),
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
