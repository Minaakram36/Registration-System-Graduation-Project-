import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:registrationsystem/screens%20v.2/signin.dart';
import 'package:registrationsystem/widgets/Database.dart';

class Changepassword extends StatefulWidget {
  const Changepassword({Key? key}) : super(key: key);

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}


class _ChangepasswordState extends State<Changepassword> {
  final _passwordController = TextEditingController();
  final _newpasswordController = TextEditingController();
  final _comfirmpasswordController = TextEditingController();

  String get password => _passwordController.text.trim();
  String get newpassword => _newpasswordController.text.trim();
  String get comfirmpassword => _comfirmpasswordController.text.trim();

  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  bool _passwordVisible2 = false;

  bool _passwordVisible3 = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Password",
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
                              keyboardType: TextInputType.text,
                              controller: _passwordController,
                              obscureText: !_passwordVisible,
                              decoration: InputDecoration(
                                labelText: 'Current Password',
                                hintText: 'Enter Your Current Password',
                                icon: const Icon(
                                  Icons.password_outlined,
                                  color: Color.fromARGB(255, 44, 75, 143),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color:
                                        const Color.fromARGB(255, 44, 75, 143),
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
                                  return 'Please Enter Your Current Password';
                                }
                                else if( !(value == currentpassword)){
                                  return 'incorrect password';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _newpasswordController,
                              obscureText: !_passwordVisible2,
                              decoration: InputDecoration(
                                labelText: 'New Password',
                                hintText: 'Enter Your New Password',
                                icon: const Icon(
                                  Icons.password_outlined,
                                  color: Color.fromARGB(255, 44, 75, 143),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible2
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color:
                                        const Color.fromARGB(255, 44, 75, 143),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible2 = !_passwordVisible2;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty ) {
                                  return 'Please Enter Your New Password';
                                }
                                else if(value.length<=4){
                                  return 'Password is so small';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _comfirmpasswordController,
                              obscureText: !_passwordVisible3,
                              decoration: InputDecoration(
                                labelText: ' Confirm New Password',
                                hintText: 'Enter Your Confirm New Password',
                                icon: const Icon(
                                  Icons.password_outlined,
                                  color: Color.fromARGB(255, 44, 75, 143),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible3
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color:
                                        const Color.fromARGB(255, 44, 75, 143),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible3 = !_passwordVisible3;
                                    });
                                  },
                                ),
                              ),

                              validator: (value) {
                                if(value!.isEmpty){
                                  return "Please, enter Comfirmation password";
                                }

                                else if(!(value == newpassword)) {
                                  return 'Please Enter correct password';
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
                                    backgroundColor: MaterialStateProperty.all<
                                            Color>(
                                        const Color.fromARGB(255, 44, 75, 143)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        side: BorderSide(
                                          color:
                                              Color.fromARGB(255, 44, 75, 143),
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: const Text('Change Password'),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {

                                      updateuserinfo(context,Userid!,password: comfirmpassword);
                                      currentpassword=comfirmpassword;
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
          ],
        ),
      ),
    );
  }
}
