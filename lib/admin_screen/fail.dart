import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class fail extends StatefulWidget {
  String studentid;
  String studentname;

  fail(this.studentid, this.studentname, {Key? key}) : super(key: key);
  @override
  State<fail> createState() => _failState();
}

class _failState extends State<fail> {
  var coursecontroller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.studentname,
        ),
        backgroundColor: const Color.fromARGB(255, 44, 75, 143),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 20),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(widget.studentid)
                .collection('Coursesfailed')
                .snapshots(),
            builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              final docs = snapshot.data!.docs;

              return ListView.builder(
                  controller: coursecontroller,
                  itemCount: docs.length,
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        Container(
                          color: Colors.redAccent,
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
                                    child: const Icon(
                                      Icons.menu_book,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        width: 240,
                                        child: Text(
                                          docs[index]['Name'],
                                          style: const TextStyle(
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
                                          docs[index]['Credithoure']
                                                  .toString() +
                                              'ch',
                                          style: const TextStyle(
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
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Text(
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
                                            docs[index].id,
                                            style: const TextStyle(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Text(
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
                                        child:
                                            // Text(
                                            //   docs[index]['Doctor'].toString(),
                                            //   style: const TextStyle(
                                            //     color: Colors.white,
                                            //     fontSize: 14,
                                            //     fontWeight: FontWeight.w200,
                                            //     letterSpacing: 1.0,
                                            //   ),
                                            // ),

                                            Text(
                                          'test',
                                          style: const TextStyle(
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
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
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
                                    child:
                                        // Text(
                                        //   'Grade :' +
                                        //       docs[index]['Grade'].toString(),
                                        //   style: const TextStyle(
                                        //     color: Colors.white,
                                        //     fontSize: 14,
                                        //     fontWeight: FontWeight.w200,
                                        //     letterSpacing: 1.0,
                                        //   ),
                                        // ),
                                        Text(
                                      'Grade :' + docs[index]['Grade'],
                                      style: const TextStyle(
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
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  });
            }),
      ),
    );
  }
}
