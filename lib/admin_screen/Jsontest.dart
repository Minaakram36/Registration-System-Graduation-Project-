import 'package:flutter/material.dart';
import 'package:registrationsystem/widgets/Database.dart';

class jsontest extends StatefulWidget {
  const jsontest({Key? key}) : super(key: key);

  @override
  State<jsontest> createState() => _jsontestState();
}

class _jsontestState extends State<jsontest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child:
            Container(
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
            child: const Text('Submit'),
            onPressed: () {
              StoreJsontoFirebase();
            },
          ),
        )
            ,
      ),
    );
  }
}
