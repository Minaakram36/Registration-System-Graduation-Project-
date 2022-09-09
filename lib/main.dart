import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'package:registrationsystem/screens v.2/signin.dart';

//import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Registration system',
      theme: ThemeData(
        // primarySwatch: Colors.pink,
          canvasColor: const Color.fromRGBO(255, 255, 255, 1),
          textTheme: ThemeData.light().textTheme.copyWith(
            // ignore: deprecated_member_use
              bodyText1: const TextStyle(color: Color.fromRGBO(20, 50, 50, 1)),
              // ignore: deprecated_member_use
              bodyText2: const TextStyle(color: Color.fromRGBO(20, 50, 50, 1)),
              subtitle1: const TextStyle(
                //fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold)),
          colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: Colors.amber)),
      routes: {
        '/': (context) => Signin()
      },
    );

  }
}

