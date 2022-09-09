import 'package:flutter/material.dart';
import 'package:registrationsystem/screens v.2/about_categorie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:registrationsystem/screens%20v.2/failed_categorie.dart';
import 'package:registrationsystem/screens%20v.2/signin.dart';
import 'completed_categorie.dart';
import 'inprogress_categorie.dart';


class CategoryScreen extends StatefulWidget {
  String categoryTitle;
  CategoryScreen({Key? key, required this.categoryTitle}) : super(key: key);
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late String categoryTitle;
  late Color color;
  var coursecontroller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 44, 75, 143),
        title: Text(widget.categoryTitle),
      ),
      body: widget.categoryTitle != 'About' &&
          widget.categoryTitle != 'In Progress Courses' &&
          widget.categoryTitle != 'Failed Courses'&&
          widget.categoryTitle != 'Schedule'&&
          widget.categoryTitle != 'Announcement'
          ? StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(Userid)
            .collection('Coursesdone')
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          final docs = snapshot.data!.docs;

          //docs.forEach((element) {x.add(element['Credithoure']);});
          // print(x);

          return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (ctx, index) {
                if (widget.categoryTitle == 'Compeleted Courses') {
                  return completed_categorie(
                    classTopic: docs[index]['Name'],
                    course_credit_hours:
                    docs[index]['Credithoure'].toString(),
                    course_code: docs[index].id,
                    professor: docs[index]['Doctor'].toString(),
                    course_grade: docs[index]['Grade'].toString(),
                  );
                }
                return const Text('');
              });
        },
      )
          : widget.categoryTitle != 'About' &&
          widget.categoryTitle != 'Compeleted Courses' &&
          widget.categoryTitle != 'Failed Courses'&&
          widget.categoryTitle != 'Schedule'&&
          widget.categoryTitle != 'Announcement'
          ? Column(
        children: [
          Flexible(
            flex: 8,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(Userid)
                  .collection('Courses')
                  .snapshots(),
              builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                final docs = snapshot.data!.docs;

                //docs.forEach((element) {x.add(element['Credithoure']);});
                // print(x);

                return ListView.builder(
                    controller: coursecontroller,
                    itemCount: docs.length,
                    itemBuilder: (ctx, index) {
                      if (widget.categoryTitle ==
                          'In Progress Courses') {
                        return inprogress_categorie(
                          classTopic: docs[index]['Name'],
                          course_credit_hours:
                          docs[index]['Credithoure'].toString(),
                          course_code: docs[index].id,
                          professor: docs[index]['Doctor'].toString(),
                          time: docs[index]['Time'].toString(),
                          course_grade:
                          docs[index]['Grade'].toString(),
                        );

                      }
                      return const Text('');
                    });
              },
            ),
          ),
          Flexible(
            flex: 1,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(Userid)
                    .snapshots(),
                builder:
                    (ctx, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  final docs = snapshot.data!;

                  return Center(
                    child: Container(
                      child: Text(
                        'Semester GPA : ' +
                            docs['Semestergpa'].toString(),
                        style: const TextStyle(
                          color: Color.fromARGB(255, 184, 16, 50),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      )
          : widget.categoryTitle != 'About' &&
          widget.categoryTitle != 'In Progress Courses' &&
          widget.categoryTitle != 'Compeleted Courses'&&
          widget.categoryTitle != 'Schedule'&&
          widget.categoryTitle != 'Announcement'
          ? StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(Userid)
            .collection('Coursesfailed')
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          final docs = snapshot.data!.docs;

          //docs.forEach((element) {x.add(element['Credithoure']);});
          // print(x);

          return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (ctx, index) {
                if (widget.categoryTitle == 'Failed Courses') {
                  return failed_categorie(
                    classTopic: docs[index]['Name'],
                    course_credit_hours:
                    docs[index]['Credithoure'].toString(),
                    course_code: docs[index].id,
                    professor: docs[index]['Doctor'],
                    course_grade:docs[index]['Grade'],
                  );
                }
                return const Text('');
              });
        },
      )
          :
      widget.categoryTitle != 'About' &&
          widget.categoryTitle != 'In Progress Courses' &&
          widget.categoryTitle != 'Compeleted Courses'&&
          widget.categoryTitle != 'Failed Courses'&&
          widget.categoryTitle != 'Announcement'
          ? Column(
        children: [
          Flexible(
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(10),
                          child:  Table(
                            columnWidths: const {
                              0: FlexColumnWidth(3.3),
                              1: FlexColumnWidth(6.7),
                              2: FlexColumnWidth(5.2),
                              3: FlexColumnWidth(3.8),
                            },
                            border: TableBorder.all(
                              width: 2,
                            ),
                            children: [
                              const TableRow(
                                  decoration:  BoxDecoration(
                                    color: Color.fromARGB(
                                        212, 226, 232, 236),
                                  ),
                                  children: [
                                    Center(
                                        child: Center(
                                          child: Padding(
                                            padding:
                                            EdgeInsets.all(
                                                8.0),
                                            child: Text(
                                                '-',
                                                style:
                                                TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                )),
                                          ),
                                        )),
                                    Center(
                                        child: Center(
                                          child: Padding(
                                            padding:
                                            EdgeInsets.all(8.0),
                                            child: Text('9:11',
                                                style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                )),
                                          ),
                                        )),
                                    Center(
                                        child: Center(
                                          child: Padding(
                                            padding:
                                            EdgeInsets.all(8.0),
                                            child: Text('11:01',
                                                style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                )),
                                          ),
                                        )),
                                    Center(
                                        child: Center(
                                          child: Padding(
                                            padding:
                                            EdgeInsets.all(8.0),
                                            child: Text('1:03',
                                                style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                )),
                                          ),
                                        )),
                                  ]),
                              TableRow(
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(
                                        212, 226, 232, 236),
                                  ),
                                  children: [
                                    const Center(
                                        child: Center(
                                          child: Padding(
                                            padding:
                                            EdgeInsets.all(8.0),
                                            child: Text('Saturday',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                    fontSize: 13)),
                                          ),
                                        )),
                                    Center(
                                        child: Center(
                                          child: Padding(
                                              padding:
                                              const EdgeInsets.all(
                                                  8.0),
                                              child: StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                      'Users')
                                                      .doc(Userid)
                                                      .collection(
                                                      'Schedule')
                                                      .doc('days')
                                                      .collection(
                                                      'saturday')
                                                      .where('Time',
                                                      isEqualTo:
                                                      '9:11')
                                                      .snapshots(),
                                                  builder: (ctx,
                                                      AsyncSnapshot<
                                                          QuerySnapshot>
                                                      snapshot) {
                                                    if (snapshot
                                                        .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const CircularProgressIndicator();
                                                    }

                                                    final subject =
                                                        snapshot.data!
                                                            .docs;

                                                    return ListView
                                                        .builder(
                                                      //Element-5
                                                      shrinkWrap:
                                                      true,
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      physics:
                                                      const NeverScrollableScrollPhysics(),
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      itemCount:
                                                      subject
                                                          .length,
                                                      itemBuilder:
                                                          (context,
                                                          subjectindex) {
                                                        return Column(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Text(
                                                                    subject[subjectindex]['Name'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Doctor'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Room'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                              ],
                                                            ),

                                                          ],
                                                        );
                                                      },
                                                    );
                                                  })),
                                        )),
                                    Center(
                                        child: Center(
                                          child: Padding(
                                              padding:
                                              const EdgeInsets.all(
                                                  8.0),
                                              child: StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                      'Users')
                                                      .doc(Userid)
                                                      .collection(
                                                      'Schedule')
                                                      .doc('days')
                                                      .collection(
                                                      'saturday')
                                                      .where('Time',
                                                      isEqualTo:
                                                      '11:01')
                                                      .snapshots(),
                                                  builder: (ctx,
                                                      AsyncSnapshot<
                                                          QuerySnapshot>
                                                      snapshot) {
                                                    if (snapshot
                                                        .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const CircularProgressIndicator();
                                                    }

                                                    final subject =
                                                        snapshot.data!
                                                            .docs;

                                                    return ListView
                                                        .builder(
                                                      //Element-5
                                                      shrinkWrap:
                                                      true,
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      physics:
                                                      const NeverScrollableScrollPhysics(),
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      itemCount:
                                                      subject
                                                          .length,
                                                      itemBuilder:
                                                          (context,
                                                          subjectindex) {
                                                        return Column(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Text(
                                                                    subject[subjectindex]['Name'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Doctor'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Room'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                              ],
                                                            ),

                                                          ],
                                                        );
                                                      },
                                                    );
                                                  })),
                                        )),
                                    Center(
                                        child: Center(
                                          child: Padding(
                                              padding:
                                              const EdgeInsets.all(
                                                  8.0),
                                              child: StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                      'Users')
                                                      .doc(Userid)
                                                      .collection(
                                                      'Schedule')
                                                      .doc('days')
                                                      .collection(
                                                      'saturday')
                                                      .where('Time',
                                                      isEqualTo:
                                                      '1:03')
                                                      .snapshots(),
                                                  builder: (ctx,
                                                      AsyncSnapshot<
                                                          QuerySnapshot>
                                                      snapshot) {
                                                    if (snapshot
                                                        .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const CircularProgressIndicator();
                                                    }

                                                    final subject =
                                                        snapshot.data!
                                                            .docs;

                                                    return ListView
                                                        .builder(
                                                      //Element-5
                                                      shrinkWrap:
                                                      true,
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      physics:
                                                      const NeverScrollableScrollPhysics(),
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      itemCount:
                                                      subject
                                                          .length,
                                                      itemBuilder:
                                                          (context,
                                                          subjectindex) {
                                                        return Column(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Text(
                                                                    subject[subjectindex]['Name'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Doctor'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Room'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                              ],
                                                            ),

                                                          ],
                                                        );
                                                      },
                                                    );
                                                  })),
                                        )),
                                  ]),
                              TableRow(
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(
                                        212, 226, 232, 236),
                                  ),
                                  children: [
                                    const Center(
                                        child: Center(
                                          child: Padding(
                                            padding:
                                            EdgeInsets.all(8.0),
                                            child: Text('Sunday',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                    fontSize: 13)),
                                          ),
                                        )),
                                    Center(
                                        child: Center(
                                          child: Padding(
                                              padding:
                                              const EdgeInsets.all(
                                                  8.0),
                                              child: StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                      'Users')
                                                      .doc(Userid)
                                                      .collection(
                                                      'Schedule')
                                                      .doc('days')
                                                      .collection(
                                                      'sunday')
                                                      .where('Time',
                                                      isEqualTo:
                                                      '9:11')
                                                      .snapshots(),
                                                  builder: (ctx,
                                                      AsyncSnapshot<
                                                          QuerySnapshot>
                                                      snapshot) {
                                                    if (snapshot
                                                        .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const CircularProgressIndicator();
                                                    }

                                                    final subject =
                                                        snapshot.data!
                                                            .docs;

                                                    return ListView
                                                        .builder(
                                                      //Element-5
                                                      shrinkWrap:
                                                      true,
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      physics:
                                                      const NeverScrollableScrollPhysics(),
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      itemCount:
                                                      subject
                                                          .length,
                                                      itemBuilder:
                                                          (context,
                                                          subjectindex) {
                                                        return Column(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Text(
                                                                    subject[subjectindex]['Name'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Doctor'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Room'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                              ],
                                                            ),

                                                          ],
                                                        );
                                                      },
                                                    );
                                                  })),
                                        )),
                                    Center(
                                        child: Center(
                                          child: Padding(
                                              padding:
                                              const EdgeInsets.all(
                                                  8.0),
                                              child: StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                      'Users')
                                                      .doc(Userid)
                                                      .collection(
                                                      'Schedule')
                                                      .doc('days')
                                                      .collection(
                                                      'sunday')
                                                      .where('Time',
                                                      isEqualTo:
                                                      '11:01')
                                                      .snapshots(),
                                                  builder: (ctx,
                                                      AsyncSnapshot<
                                                          QuerySnapshot>
                                                      snapshot) {
                                                    if (snapshot
                                                        .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const CircularProgressIndicator();
                                                    }

                                                    final subject =
                                                        snapshot.data!
                                                            .docs;

                                                    return ListView
                                                        .builder(
                                                      //Element-5
                                                      shrinkWrap:
                                                      true,
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      physics:
                                                      const NeverScrollableScrollPhysics(),
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      itemCount:
                                                      subject
                                                          .length,
                                                      itemBuilder:
                                                          (context,
                                                          subjectindex) {
                                                        return Column(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Text(
                                                                    subject[subjectindex]['Name'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Doctor'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Room'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                              ],
                                                            ),

                                                          ],
                                                        );
                                                      },
                                                    );
                                                  })),
                                        )),
                                    Center(
                                        child: Center(
                                          child: Padding(
                                              padding:
                                              const EdgeInsets.all(
                                                  8.0),
                                              child: StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                      'Users')
                                                      .doc(Userid)
                                                      .collection(
                                                      'Schedule')
                                                      .doc('days')
                                                      .collection(
                                                      'sunday')
                                                      .where('Time',
                                                      isEqualTo:
                                                      '1:03')
                                                      .snapshots(),
                                                  builder: (ctx,
                                                      AsyncSnapshot<
                                                          QuerySnapshot>
                                                      snapshot) {
                                                    if (snapshot
                                                        .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const CircularProgressIndicator();
                                                    }

                                                    final subject =
                                                        snapshot.data!
                                                            .docs;

                                                    return ListView
                                                        .builder(
                                                      //Element-5
                                                      shrinkWrap:
                                                      true,
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      physics:
                                                      const NeverScrollableScrollPhysics(),
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      itemCount:
                                                      subject
                                                          .length,
                                                      itemBuilder:
                                                          (context,
                                                          subjectindex) {
                                                        return Column(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Text(
                                                                    subject[subjectindex]['Name'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Doctor'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Room'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                              ],
                                                            ),

                                                          ],
                                                        );
                                                      },
                                                    );
                                                  })),
                                        )),
                                  ]),
                              TableRow(
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(
                                        212, 226, 232, 236),
                                  ),
                                  children: [
                                    const Center(
                                        child: Center(
                                          child: Padding(
                                            padding:
                                            EdgeInsets.all(8.0),
                                            child: Text('Monday',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                    fontSize: 13)),
                                          ),
                                        )),
                                    Center(
                                        child: Center(
                                          child: Padding(
                                              padding:
                                              const EdgeInsets.all(
                                                  8.0),
                                              child: StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                      'Users')
                                                      .doc(Userid)
                                                      .collection(
                                                      'Schedule')
                                                      .doc('days')
                                                      .collection(
                                                      'monday')
                                                      .where('Time',
                                                      isEqualTo:
                                                      '9:11')
                                                      .snapshots(),
                                                  builder: (ctx,
                                                      AsyncSnapshot<
                                                          QuerySnapshot>
                                                      snapshot) {
                                                    if (snapshot
                                                        .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const CircularProgressIndicator();
                                                    }

                                                    final subject =
                                                        snapshot.data!
                                                            .docs;

                                                    return ListView
                                                        .builder(
                                                      //Element-5
                                                      shrinkWrap:
                                                      true,
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      physics:
                                                      const NeverScrollableScrollPhysics(),
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      itemCount:
                                                      subject
                                                          .length,
                                                      itemBuilder:
                                                          (context,
                                                          subjectindex) {
                                                        return Column(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Text(
                                                                    subject[subjectindex]['Name'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Doctor'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Room'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                              ],
                                                            ),

                                                          ],
                                                        );
                                                      },
                                                    );
                                                  })),
                                        )),
                                    Center(
                                        child: Center(
                                          child: Padding(
                                              padding:
                                              const EdgeInsets.all(
                                                  8.0),
                                              child: StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                      'Users')
                                                      .doc(Userid)
                                                      .collection(
                                                      'Schedule')
                                                      .doc('days')
                                                      .collection(
                                                      'monday')
                                                      .where('Time',
                                                      isEqualTo:
                                                      '11:01')
                                                      .snapshots(),
                                                  builder: (ctx,
                                                      AsyncSnapshot<
                                                          QuerySnapshot>
                                                      snapshot) {
                                                    if (snapshot
                                                        .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const CircularProgressIndicator();
                                                    }

                                                    final subject =
                                                        snapshot.data!
                                                            .docs;

                                                    return ListView
                                                        .builder(
                                                      //Element-5
                                                      shrinkWrap:
                                                      true,
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      physics:
                                                      const NeverScrollableScrollPhysics(),
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      itemCount:
                                                      subject
                                                          .length,
                                                      itemBuilder:
                                                          (context,
                                                          subjectindex) {
                                                        return Column(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Text(
                                                                    subject[subjectindex]['Name'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Doctor'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Room'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                              ],
                                                            ),

                                                          ],
                                                        );
                                                      },
                                                    );
                                                  })),
                                        )),
                                    Center(
                                        child: Center(
                                          child: Padding(
                                              padding:
                                              const EdgeInsets.all(
                                                  8.0),
                                              child: StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                      'Users')
                                                      .doc(Userid)
                                                      .collection(
                                                      'Schedule')
                                                      .doc('days')
                                                      .collection(
                                                      'monday')
                                                      .where('Time',
                                                      isEqualTo:
                                                      '1:03')
                                                      .snapshots(),
                                                  builder: (ctx,
                                                      AsyncSnapshot<
                                                          QuerySnapshot>
                                                      snapshot) {
                                                    if (snapshot
                                                        .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const CircularProgressIndicator();
                                                    }

                                                    final subject =
                                                        snapshot.data!
                                                            .docs;

                                                    return ListView
                                                        .builder(
                                                      //Element-5
                                                      shrinkWrap:
                                                      true,
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      physics:
                                                      const NeverScrollableScrollPhysics(),
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      itemCount:
                                                      subject
                                                          .length,
                                                      itemBuilder:
                                                          (context,
                                                          subjectindex) {
                                                        return Column(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Text(
                                                                    subject[subjectindex]['Name'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Doctor'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Room'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                              ],
                                                            ),

                                                          ],
                                                        );
                                                      },
                                                    );
                                                  })),
                                        )),
                                  ]),
                              TableRow(
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(
                                        212, 226, 232, 236),
                                  ),
                                  children: [
                                    const Center(
                                        child: Center(
                                          child: Padding(
                                            padding:
                                            EdgeInsets.all(8.0),
                                            child: Text('Tuesday',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                    fontSize: 13)),
                                          ),
                                        )),
                                    Center(
                                        child: Center(
                                          child: Padding(
                                              padding:
                                              const EdgeInsets.all(
                                                  8.0),
                                              child: StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                      'Users')
                                                      .doc(Userid)
                                                      .collection(
                                                      'Schedule')
                                                      .doc('days')
                                                      .collection(
                                                      'tuesday')
                                                      .where('Time',
                                                      isEqualTo:
                                                      '9:11')
                                                      .snapshots(),
                                                  builder: (ctx,
                                                      AsyncSnapshot<
                                                          QuerySnapshot>
                                                      snapshot) {
                                                    if (snapshot
                                                        .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const CircularProgressIndicator();
                                                    }

                                                    final subject =
                                                        snapshot.data!
                                                            .docs;

                                                    return ListView
                                                        .builder(
                                                      //Element-5
                                                      shrinkWrap:
                                                      true,
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      physics:
                                                      const NeverScrollableScrollPhysics(),
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      itemCount:
                                                      subject
                                                          .length,
                                                      itemBuilder:
                                                          (context,
                                                          subjectindex) {
                                                        return Column(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Text(
                                                                    subject[subjectindex]['Name'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Doctor'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Room'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                              ],
                                                            ),

                                                          ],
                                                        );
                                                      },
                                                    );
                                                  })),
                                        )),
                                    Center(
                                        child: Center(
                                          child: Padding(
                                              padding:
                                              const EdgeInsets.all(
                                                  8.0),
                                              child: StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                      'Users')
                                                      .doc(Userid)
                                                      .collection(
                                                      'Schedule')
                                                      .doc('days')
                                                      .collection(
                                                      'tuesday')
                                                      .where('Time',
                                                      isEqualTo:
                                                      '11:01')
                                                      .snapshots(),
                                                  builder: (ctx,
                                                      AsyncSnapshot<
                                                          QuerySnapshot>
                                                      snapshot) {
                                                    if (snapshot
                                                        .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const CircularProgressIndicator();
                                                    }

                                                    final subject =
                                                        snapshot.data!
                                                            .docs;

                                                    return ListView
                                                        .builder(
                                                      //Element-5
                                                      shrinkWrap:
                                                      true,
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      physics:
                                                      const NeverScrollableScrollPhysics(),
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      itemCount:
                                                      subject
                                                          .length,
                                                      itemBuilder:
                                                          (context,
                                                          subjectindex) {
                                                        return Column(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Text(
                                                                    subject[subjectindex]['Name'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Doctor'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Room'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                              ],
                                                            ),

                                                          ],
                                                        );
                                                      },
                                                    );
                                                  })),
                                        )),
                                    Center(
                                        child: Center(
                                          child: Padding(
                                              padding:
                                              const EdgeInsets.all(
                                                  8.0),
                                              child: StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                      'Users')
                                                      .doc(Userid)
                                                      .collection(
                                                      'Schedule')
                                                      .doc('days')
                                                      .collection(
                                                      'tuesday')
                                                      .where('Time',
                                                      isEqualTo:
                                                      '1:03')
                                                      .snapshots(),
                                                  builder: (ctx,
                                                      AsyncSnapshot<
                                                          QuerySnapshot>
                                                      snapshot) {
                                                    if (snapshot
                                                        .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const CircularProgressIndicator();
                                                    }

                                                    final subject =
                                                        snapshot.data!
                                                            .docs;

                                                    return ListView
                                                        .builder(
                                                      //Element-5
                                                      shrinkWrap:
                                                      true,
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      physics:
                                                      const NeverScrollableScrollPhysics(),
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      itemCount:
                                                      subject
                                                          .length,
                                                      itemBuilder:
                                                          (context,
                                                          subjectindex) {
                                                        return Column(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Text(
                                                                    subject[subjectindex]['Name'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Doctor'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Room'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                              ],
                                                            ),

                                                          ],
                                                        );
                                                      },
                                                    );
                                                  })),
                                        )),
                                  ]),
                              TableRow(
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(
                                        212, 226, 232, 236),
                                  ),
                                  children: [
                                    const Center(
                                        child: Center(
                                          child: Padding(
                                            padding:
                                            EdgeInsets.all(8.0),
                                            child: Text('Wednesday',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                    fontSize: 13)),
                                          ),
                                        )),
                                    Center(
                                        child: Center(
                                          child: Padding(
                                              padding:
                                              const EdgeInsets.all(
                                                  8.0),
                                              child: StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                      'Users')
                                                      .doc(Userid)
                                                      .collection(
                                                      'Schedule')
                                                      .doc('days')
                                                      .collection(
                                                      'wednesday')
                                                      .where('Time',
                                                      isEqualTo:
                                                      '9:11')
                                                      .snapshots(),
                                                  builder: (ctx,
                                                      AsyncSnapshot<
                                                          QuerySnapshot>
                                                      snapshot) {
                                                    if (snapshot
                                                        .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const CircularProgressIndicator();
                                                    }

                                                    final subject =
                                                        snapshot.data!
                                                            .docs;

                                                    return ListView
                                                        .builder(
                                                      //Element-5
                                                      shrinkWrap:
                                                      true,
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      physics:
                                                      const NeverScrollableScrollPhysics(),
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      itemCount:
                                                      subject
                                                          .length,
                                                      itemBuilder:
                                                          (context,
                                                          subjectindex) {
                                                        return Column(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Text(
                                                                    subject[subjectindex]['Name'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Doctor'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Room'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                              ],
                                                            ),

                                                          ],
                                                        );
                                                      },
                                                    );
                                                  })),
                                        )),
                                    Center(
                                        child: Center(
                                          child: Padding(
                                              padding:
                                              const EdgeInsets.all(
                                                  8.0),
                                              child: StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                      'Users')
                                                      .doc(Userid)
                                                      .collection(
                                                      'Schedule')
                                                      .doc('days')
                                                      .collection(
                                                      'wednesday')
                                                      .where('Time',
                                                      isEqualTo:
                                                      '11:01')
                                                      .snapshots(),
                                                  builder: (ctx,
                                                      AsyncSnapshot<
                                                          QuerySnapshot>
                                                      snapshot) {
                                                    if (snapshot
                                                        .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const CircularProgressIndicator();
                                                    }

                                                    final subject =
                                                        snapshot.data!
                                                            .docs;

                                                    return ListView
                                                        .builder(
                                                      //Element-5
                                                      shrinkWrap:
                                                      true,
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      physics:
                                                      const NeverScrollableScrollPhysics(),
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      itemCount:
                                                      subject
                                                          .length,
                                                      itemBuilder:
                                                          (context,
                                                          subjectindex) {
                                                        return Column(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Text(
                                                                    subject[subjectindex]['Name'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Doctor'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Room'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                              ],
                                                            ),

                                                          ],
                                                        );
                                                      },
                                                    );
                                                  })),
                                        )),
                                    Center(
                                        child: Center(
                                          child: Padding(
                                              padding:
                                              const EdgeInsets.all(
                                                  8.0),
                                              child: StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                      'Users')
                                                      .doc(Userid)
                                                      .collection(
                                                      'Schedule')
                                                      .doc('days')
                                                      .collection(
                                                      'wednesday')
                                                      .where('Time',
                                                      isEqualTo:
                                                      '1:03')
                                                      .snapshots(),
                                                  builder: (ctx,
                                                      AsyncSnapshot<
                                                          QuerySnapshot>
                                                      snapshot) {
                                                    if (snapshot
                                                        .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const CircularProgressIndicator();
                                                    }

                                                    final subject =
                                                        snapshot.data!
                                                            .docs;

                                                    return ListView
                                                        .builder(
                                                      //Element-5
                                                      shrinkWrap:
                                                      true,
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      physics:
                                                      const NeverScrollableScrollPhysics(),
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      itemCount:
                                                      subject
                                                          .length,
                                                      itemBuilder:
                                                          (context,
                                                          subjectindex) {
                                                        return Column(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Text(
                                                                    subject[subjectindex]['Name'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Doctor'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Room'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                              ],
                                                            ),

                                                          ],
                                                        );
                                                      },
                                                    );
                                                  })),
                                        )),
                                  ]),
                              TableRow(
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(
                                        212, 226, 232, 236),
                                  ),
                                  children: [
                                    const Center(
                                        child: Center(
                                          child: Padding(
                                            padding:
                                            EdgeInsets.all(8.0),
                                            child: Text('Thursday',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                    fontSize: 13)),
                                          ),
                                        )),
                                    Center(
                                        child: Center(
                                          child: Padding(
                                              padding:
                                              const EdgeInsets.all(
                                                  8.0),
                                              child: StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                      'Users')
                                                      .doc(Userid)
                                                      .collection(
                                                      'Schedule')
                                                      .doc('days')
                                                      .collection(
                                                      'thursday')
                                                      .where('Time',
                                                      isEqualTo:
                                                      '9:11')
                                                      .snapshots(),
                                                  builder: (ctx,
                                                      AsyncSnapshot<
                                                          QuerySnapshot>
                                                      snapshot) {
                                                    if (snapshot
                                                        .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const CircularProgressIndicator();
                                                    }

                                                    final subject =
                                                        snapshot.data!
                                                            .docs;

                                                    return ListView
                                                        .builder(
                                                      //Element-5
                                                      shrinkWrap:
                                                      true,
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      physics:
                                                      const NeverScrollableScrollPhysics(),
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      itemCount:
                                                      subject
                                                          .length,
                                                      itemBuilder:
                                                          (context,
                                                          subjectindex) {
                                                        return Column(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Text(
                                                                    subject[subjectindex]['Name'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Doctor'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Room'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                              ],
                                                            ),

                                                          ],
                                                        );
                                                      },
                                                    );
                                                  })),
                                        )),
                                    Center(
                                        child: Center(
                                          child: Padding(
                                              padding:
                                              const EdgeInsets.all(
                                                  8.0),
                                              child: StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                      'Users')
                                                      .doc(Userid)
                                                      .collection(
                                                      'Schedule')
                                                      .doc('days')
                                                      .collection(
                                                      'thursday')
                                                      .where('Time',
                                                      isEqualTo:
                                                      '11:01')
                                                      .snapshots(),
                                                  builder: (ctx,
                                                      AsyncSnapshot<
                                                          QuerySnapshot>
                                                      snapshot) {
                                                    if (snapshot
                                                        .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const CircularProgressIndicator();
                                                    }

                                                    final subject =
                                                        snapshot.data!
                                                            .docs;

                                                    return ListView
                                                        .builder(
                                                      //Element-5
                                                      shrinkWrap:
                                                      true,
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      physics:
                                                      const NeverScrollableScrollPhysics(),
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      itemCount:
                                                      subject
                                                          .length,
                                                      itemBuilder:
                                                          (context,
                                                          subjectindex) {
                                                        return Column(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Text(
                                                                    subject[subjectindex]['Name'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Doctor'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Room'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                              ],
                                                            ),

                                                          ],
                                                        );
                                                      },
                                                    );
                                                  })),
                                        )),
                                    Center(
                                        child: Center(
                                          child: Padding(
                                              padding:
                                              const EdgeInsets.all(
                                                  8.0),
                                              child: StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                      'Users')
                                                      .doc(Userid)
                                                      .collection(
                                                      'Schedule')
                                                      .doc('days')
                                                      .collection(
                                                      'thursday')
                                                      .where('Time',
                                                      isEqualTo:
                                                      '1:03')
                                                      .snapshots(),
                                                  builder: (ctx,
                                                      AsyncSnapshot<
                                                          QuerySnapshot>
                                                      snapshot) {
                                                    if (snapshot
                                                        .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const CircularProgressIndicator();
                                                    }

                                                    final subject =
                                                        snapshot.data!
                                                            .docs;

                                                    return ListView
                                                        .builder(
                                                      //Element-5
                                                      shrinkWrap:
                                                      true,
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      physics:
                                                      const NeverScrollableScrollPhysics(),
                                                      //this property is must when you put List/Grid View inside SingleChildScrollView
                                                      itemCount:
                                                      subject
                                                          .length,
                                                      itemBuilder:
                                                          (context,
                                                          subjectindex) {
                                                        return Column(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Text(
                                                                    subject[subjectindex]['Name'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Doctor'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    subject[subjectindex]['Room'],
                                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                              ],
                                                            ),

                                                          ],
                                                        );
                                                      },
                                                    );
                                                  })),
                                        )),
                                  ]),
                            ],
                          ),
                        ),
                      ])),
            ),
          ),
        ],
      ) :
      widget.categoryTitle != 'About' &&
          widget.categoryTitle != 'In Progress Courses' &&
          widget.categoryTitle != 'Compeleted Courses'&&
          widget.categoryTitle != 'Failed Courses'&&
          widget.categoryTitle != 'Schedule'?
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Announcements')
                    .orderBy('DateTime', descending: true)
                    .snapshots(),
                builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  final docs = snapshot.data!.docs;
                  return ListView.builder(
                      controller: ScrollController(),
                      itemCount: docs.length,
                      itemBuilder: (ctx, index) {
                        return Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 44, 75, 143),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${docs[index]['Name']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '${docs[index]['Time']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '${docs[index]['Date']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(height: 5),
                                    const Icon(
                                      Icons.alarm,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 100,
                                  width: 1,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          160,
                                      child: Text(
                                        '${docs[index]['Text']}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ;
                      });
                })

          :
      Container(
        //add to Scroll whole screen
        child: Column(
          children: <Widget>[
            Table(
              border: TableBorder.all(
                width: 2,
              ),
              children: const [
                TableRow(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 83, 138, 170),
                    ),
                    children: [
                      Center(
                        child: Text(
                          'Course',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Code',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Credit hours',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Center(
                          child: Text(
                            'Pre-requiste',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ))
                    ]),
              ],
            ),
            Flexible(
              flex: 10,
              child: SingleChildScrollView(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(listofcourses!)
                      .orderBy('number')
                      .snapshots(),
                  builder: (ctx,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    final semesters = snapshot.data!.docs;

                    return ListView.builder(
                      //Element-5
                      shrinkWrap: true,
                      //this property is must when you put List/Grid View inside SingleChildScrollView
                      physics:
                      const NeverScrollableScrollPhysics(),
                      //this property is must when you put List/Grid View inside SingleChildScrollView
                      itemCount: semesters.length,
                      itemBuilder: (context, index) {
                        return StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection(listofcourses!)
                              .doc(semesters[index].id)
                              .collection('Subjects')
                              .snapshots(),
                          builder: (ctx,
                              AsyncSnapshot<QuerySnapshot>
                              snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }

                            final docs = snapshot.data!.docs;

                            return Column(
                              children: [
                                Center(
                                    child: Text(
                                      semesters[index].id,
                                      style: const TextStyle(
                                          fontWeight:
                                          FontWeight.bold),
                                    )),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    controller: coursecontroller,
                                    itemCount: docs.length,
                                    itemBuilder: (ctx, index2) {
                                      return about_categorie(
                                        classTopic: docs[index2]
                                        ['Name'],
                                        course_code:
                                        docs[index2].id,
                                        course_credit_hours: docs[
                                        index2]
                                        ['Credithoure']
                                            .toString(),
                                        pre_requiste: docs[index2]
                                        ['Pre-requisite'],
                                      );
                                    }),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}