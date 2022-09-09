import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/Database.dart';

class choosecourses extends StatefulWidget {
  String studentid;
  String studentname;

  choosecourses(this.studentid, this.studentname, {Key? key})
      : super(key: key);

  @override
  State<choosecourses> createState() => _choosecoursesState();
}
List<bool>checkboxes =[false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false];
List<String>levellist=['','','','','','','','','','','','','','','','','',''];
List<String>sectionlist=['','','','','','','','','','','','','','','','','',''];
List<String> daylist=['','','','','','','','','','','','','','','','','',''];
List<String> subjectlist=['','','','','','','','','','','','','','','','','',''];
TextEditingController levelcontroller = TextEditingController();
TextEditingController sectioncontroller = TextEditingController();
int leveltext=100;
String sectiontext='';
levelstream(int selectlevel) {
  var levelstream;
  levelstream = FirebaseFirestore.instance.collection('Schedule').where('level', isEqualTo: selectlevel);
  return levelstream.snapshots();
}
sectionstream(String level,String selectsection){
  var sectionstream;
  sectionstream = FirebaseFirestore.instance.collection('Schedule').doc(level).collection('Sections').where('section',isEqualTo: selectsection);
  return sectionstream.snapshots();
}


class _choosecoursesState extends State<choosecourses> {
  @override
  void initState() {
    levelcontroller.clear();
    sectioncontroller.clear();
    leveltext=100;
    sectiontext='';
    checkboxes =[false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false];
    levellist=['','','','','','','','','','','','','','','','','',''];
    sectionlist=['','','','','','','','','','','','','','','','','',''];
    daylist=['','','','','','','','','','','','','','','','','',''];
    subjectlist=['','','','','','','','','','','','','','','','','',''];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
      ),
      body: Column(
        children: [
          FittedBox(
            child: DataTable(
              columns: const [
                DataColumn(
                    label: Text('Select Level',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Select Section',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(
                    Center(
                      child: TextField(
                        controller: levelcontroller,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Center(
                      child: TextField(
                        controller: sectioncontroller,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  DataCell(Center(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 44, 75, 143)),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(
                              color: Color.fromARGB(255, 44, 75, 143),
                            ),
                          ),
                        ),
                      ),
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        checkboxes =[false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false];
                        levellist=['','','','','','','','','','','','','','','','','',''];
                        sectionlist=['','','','','','','','','','','','','','','','','',''];
                        daylist=['','','','','','','','','','','','','','','','','',''];
                        subjectlist=['','','','','','','','','','','','','','','','','',''];
                        setState(() {
                          if(levelcontroller.text.trim()==''||sectioncontroller.text.trim().toUpperCase()==''){
                            leveltext=100;
                            sectiontext='' ;}
                          else{leveltext=int.parse(levelcontroller.text.trim());
                          sectiontext= sectioncontroller.text.trim().toUpperCase();}
                        });
                      },
                    ),
                  )),
                ]),
              ],
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: StreamBuilder(
                  stream: levelstream(leveltext),
                  builder: (ctx, AsyncSnapshot <QuerySnapshot>snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    final level = snapshot.data!.docs;


                    return ListView.builder(
                      //Element-5
                      shrinkWrap: true,
                      controller: ScrollController(),
                      //this property is must when you put List/Grid View inside SingleChildScrollView

                      //this property is must when you put List/Grid View inside SingleChildScrollView
                      itemCount: level.length,
                      itemBuilder: (context, levelindex) {
                        return StreamBuilder(
                          stream:sectionstream(level[levelindex].id,sectiontext),
                          builder: (ctx,
                              AsyncSnapshot<QuerySnapshot>
                              snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }

                            final sections = snapshot.data!.docs;

                            return ListView.builder(
                              //Element-5
                              controller: ScrollController(),
                              shrinkWrap: true,
                              //this property is must when you put List/Grid View inside SingleChildScrollView

                              //this property is must when you put List/Grid View inside SingleChildScrollView
                              itemCount: sections.length,
                              itemBuilder: (context, sectionindex) {
                                return
                                  Center(
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
                                                  TableRow(
                                                      decoration: const BoxDecoration(
                                                        color: Color.fromARGB(
                                                            212, 226, 232, 236),
                                                      ),
                                                      children: [
                                                        Center(
                                                            child: Center(
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets.all(
                                                                    8.0),
                                                                child: Text(
                                                                    '${level[levelindex].id} - ${sections[sectionindex].id}',
                                                                    style:
                                                                    const TextStyle(
                                                                      fontWeight:
                                                                      FontWeight.bold,
                                                                    )),
                                                              ),
                                                            )),
                                                        const Center(
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
                                                        const Center(
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
                                                        const Center(
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
                                                                          'Schedule')
                                                                          .doc(level[
                                                                      levelindex]
                                                                          .id)
                                                                          .collection(
                                                                          'Sections')
                                                                          .doc(sections[
                                                                      sectionindex]
                                                                          .id)
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
                                                                                  ],
                                                                                ),
                                                                                StatefulBuilder(
                                                                                  builder: (BuildContext
                                                                                  context,
                                                                                      void Function(void Function())
                                                                                      setState) {
                                                                                    return Checkbox(
                                                                                      value:
                                                                                      checkboxes[0],
                                                                                      onChanged:
                                                                                          (value) {
                                                                                        setState(() {
                                                                                          checkboxes[0] = !checkboxes[0];
                                                                                          levellist[0] = level[levelindex].id;
                                                                                          sectionlist[0] = sections[sectionindex].id;
                                                                                          daylist[0] = 'saturday';
                                                                                          subjectlist[0] = subject[sectionindex].id;
                                                                                        });
                                                                                      },
                                                                                    );
                                                                                  },
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
                                                                          'Schedule')
                                                                          .doc(level[
                                                                      levelindex]
                                                                          .id)
                                                                          .collection(
                                                                          'Sections')
                                                                          .doc(sections[
                                                                      sectionindex]
                                                                          .id)
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
                                                                                  ],
                                                                                ),
                                                                                StatefulBuilder(
                                                                                  builder: (BuildContext
                                                                                  context,
                                                                                      void Function(void Function())
                                                                                      setState) {
                                                                                    return Checkbox(
                                                                                      value:
                                                                                      checkboxes[1],
                                                                                      onChanged:
                                                                                          (value) {
                                                                                        setState(() {
                                                                                          checkboxes[1] = !checkboxes[1];
                                                                                          levellist[1] = level[levelindex].id;
                                                                                          sectionlist[1] = sections[sectionindex].id;
                                                                                          daylist[1] = 'saturday';
                                                                                          subjectlist[1] = subject[sectionindex].id;
                                                                                        });
                                                                                      },
                                                                                    );
                                                                                  },
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
                                                                          'Schedule')
                                                                          .doc(level[
                                                                      levelindex]
                                                                          .id)
                                                                          .collection(
                                                                          'Sections')
                                                                          .doc(sections[
                                                                      sectionindex]
                                                                          .id)
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
                                                                                  ],
                                                                                ),
                                                                                StatefulBuilder(
                                                                                  builder: (BuildContext
                                                                                  context,
                                                                                      void Function(void Function())
                                                                                      setState) {
                                                                                    return Checkbox(
                                                                                      value:
                                                                                      checkboxes[2],
                                                                                      onChanged:
                                                                                          (value) {
                                                                                        setState(() {
                                                                                          checkboxes[2] = !checkboxes[2];
                                                                                          levellist[2] = level[levelindex].id;
                                                                                          sectionlist[2] = sections[sectionindex].id;
                                                                                          daylist[2] = 'saturday';
                                                                                          subjectlist[2] = subject[sectionindex].id;
                                                                                        });
                                                                                      },
                                                                                    );
                                                                                  },
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
                                                                          'Schedule')
                                                                          .doc(level[
                                                                      levelindex]
                                                                          .id)
                                                                          .collection(
                                                                          'Sections')
                                                                          .doc(sections[
                                                                      sectionindex]
                                                                          .id)
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
                                                                                    Center(
                                                                                      child:
                                                                                      Text(subject[subjectindex]['Name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                                    ),
                                                                                    const SizedBox(
                                                                                        height: 10),
                                                                                    Center(
                                                                                      child:
                                                                                      Text(subject[subjectindex]['Doctor'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                StatefulBuilder(
                                                                                  builder: (BuildContext
                                                                                  context,
                                                                                      void Function(void Function())
                                                                                      setState) {
                                                                                    return Checkbox(
                                                                                      value:
                                                                                      checkboxes[3],
                                                                                      onChanged:
                                                                                          (value) {
                                                                                        setState(() {
                                                                                          checkboxes[3] = !checkboxes[3];
                                                                                          levellist[3] = level[levelindex].id;
                                                                                          sectionlist[3] = sections[sectionindex].id;
                                                                                          daylist[3] = 'sunday';
                                                                                          subjectlist[3] = subject[sectionindex].id;
                                                                                        });
                                                                                      },
                                                                                    );
                                                                                  },
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
                                                                          'Schedule')
                                                                          .doc(level[
                                                                      levelindex]
                                                                          .id)
                                                                          .collection(
                                                                          'Sections')
                                                                          .doc(sections[
                                                                      sectionindex]
                                                                          .id)
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
                                                                                    Center(
                                                                                      child:
                                                                                      Text(subject[subjectindex]['Name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                                    ),
                                                                                    const SizedBox(
                                                                                        height: 10),
                                                                                    Center(
                                                                                      child:
                                                                                      Text(subject[subjectindex]['Doctor'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                StatefulBuilder(
                                                                                  builder: (BuildContext
                                                                                  context,
                                                                                      void Function(void Function())
                                                                                      setState) {
                                                                                    return Checkbox(
                                                                                      value:
                                                                                      checkboxes[4],
                                                                                      onChanged:
                                                                                          (value) {
                                                                                        setState(() {
                                                                                          checkboxes[4] = !checkboxes[4];
                                                                                          levellist[4] = level[levelindex].id;
                                                                                          sectionlist[4] = sections[sectionindex].id;
                                                                                          daylist[4] = 'sunday';
                                                                                          subjectlist[4] = subject[sectionindex].id;
                                                                                        });
                                                                                      },
                                                                                    );
                                                                                  },
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
                                                                          'Schedule')
                                                                          .doc(level[
                                                                      levelindex]
                                                                          .id)
                                                                          .collection(
                                                                          'Sections')
                                                                          .doc(sections[
                                                                      sectionindex]
                                                                          .id)
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
                                                                                  ],
                                                                                ),
                                                                                StatefulBuilder(
                                                                                  builder: (BuildContext
                                                                                  context,
                                                                                      void Function(void Function())
                                                                                      setState) {
                                                                                    return Checkbox(
                                                                                      value:
                                                                                      checkboxes[5],
                                                                                      onChanged:
                                                                                          (value) {
                                                                                        setState(() {
                                                                                          checkboxes[5] = !checkboxes[5];
                                                                                          levellist[5] = level[levelindex].id;
                                                                                          sectionlist[5] = sections[sectionindex].id;
                                                                                          daylist[5] = 'sunday';
                                                                                          subjectlist[5] = subject[sectionindex].id;
                                                                                        });
                                                                                      },
                                                                                    );
                                                                                  },
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
                                                                          'Schedule')
                                                                          .doc(level[
                                                                      levelindex]
                                                                          .id)
                                                                          .collection(
                                                                          'Sections')
                                                                          .doc(sections[
                                                                      sectionindex]
                                                                          .id)
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
                                                                                  ],
                                                                                ),
                                                                                StatefulBuilder(
                                                                                  builder: (BuildContext
                                                                                  context,
                                                                                      void Function(void Function())
                                                                                      setState) {
                                                                                    return Checkbox(
                                                                                      value:
                                                                                      checkboxes[6],
                                                                                      onChanged:
                                                                                          (value) {
                                                                                        setState(() {
                                                                                          checkboxes[6] = !checkboxes[6];
                                                                                          levellist[6] = level[levelindex].id;
                                                                                          sectionlist[6] = sections[sectionindex].id;
                                                                                          daylist[6] = 'monday';
                                                                                          subjectlist[6] = subject[sectionindex].id;
                                                                                        });
                                                                                      },
                                                                                    );
                                                                                  },
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
                                                                          'Schedule')
                                                                          .doc(level[
                                                                      levelindex]
                                                                          .id)
                                                                          .collection(
                                                                          'Sections')
                                                                          .doc(sections[
                                                                      sectionindex]
                                                                          .id)
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
                                                                                  ],
                                                                                ),
                                                                                StatefulBuilder(
                                                                                  builder: (BuildContext
                                                                                  context,
                                                                                      void Function(void Function())
                                                                                      setState) {
                                                                                    return Checkbox(
                                                                                      value:
                                                                                      checkboxes[7],
                                                                                      onChanged:
                                                                                          (value) {
                                                                                        setState(() {
                                                                                          checkboxes[7] = !checkboxes[7];
                                                                                          levellist[7] = level[levelindex].id;
                                                                                          sectionlist[7] = sections[sectionindex].id;
                                                                                          daylist[7] = 'monday';
                                                                                          subjectlist[7] = subject[sectionindex].id;
                                                                                        });
                                                                                      },
                                                                                    );
                                                                                  },
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
                                                                          'Schedule')
                                                                          .doc(level[
                                                                      levelindex]
                                                                          .id)
                                                                          .collection(
                                                                          'Sections')
                                                                          .doc(sections[
                                                                      sectionindex]
                                                                          .id)
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
                                                                                  ],
                                                                                ),
                                                                                StatefulBuilder(
                                                                                  builder: (BuildContext
                                                                                  context,
                                                                                      void Function(void Function())
                                                                                      setState) {
                                                                                    return Checkbox(
                                                                                      value:
                                                                                      checkboxes[8],
                                                                                      onChanged:
                                                                                          (value) {
                                                                                        setState(() {
                                                                                          checkboxes[8] = !checkboxes[8];
                                                                                          levellist[8] = level[levelindex].id;
                                                                                          sectionlist[8] = sections[sectionindex].id;
                                                                                          daylist[8] = 'monday';
                                                                                          subjectlist[8] = subject[sectionindex].id;
                                                                                        });
                                                                                      },
                                                                                    );
                                                                                  },
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
                                                                  padding: const EdgeInsets
                                                                      .all(8.0),
                                                                  child: StreamBuilder(
                                                                      stream: FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                          'Schedule')
                                                                          .doc(level[
                                                                      levelindex]
                                                                          .id)
                                                                          .collection(
                                                                          'Sections')
                                                                          .doc(sections[
                                                                      sectionindex]
                                                                          .id)
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
                                                                                  ],
                                                                                ),
                                                                                StatefulBuilder(
                                                                                  builder: (BuildContext
                                                                                  context,
                                                                                      void Function(void Function())
                                                                                      setState) {
                                                                                    return Checkbox(
                                                                                      value:
                                                                                      checkboxes[9],
                                                                                      onChanged:
                                                                                          (value) {
                                                                                        setState(() {
                                                                                          checkboxes[9] = !checkboxes[9];
                                                                                          levellist[9] = level[levelindex].id;
                                                                                          sectionlist[9] = sections[sectionindex].id;
                                                                                          daylist[9] = 'tuesday';
                                                                                          subjectlist[9] = subject[sectionindex].id;
                                                                                        });
                                                                                      },
                                                                                    );
                                                                                  },
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
                                                                  padding: const EdgeInsets
                                                                      .all(8.0),
                                                                  child: StreamBuilder(
                                                                      stream: FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                          'Schedule')
                                                                          .doc(level[
                                                                      levelindex]
                                                                          .id)
                                                                          .collection(
                                                                          'Sections')
                                                                          .doc(sections[
                                                                      sectionindex]
                                                                          .id)
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
                                                                                  ],
                                                                                ),
                                                                                StatefulBuilder(
                                                                                  builder: (BuildContext
                                                                                  context,
                                                                                      void Function(void Function())
                                                                                      setState) {
                                                                                    return Checkbox(
                                                                                      value:
                                                                                      checkboxes[10],
                                                                                      onChanged:
                                                                                          (value) {
                                                                                        setState(() {
                                                                                          checkboxes[10] = !checkboxes[10];
                                                                                          levellist[10] = level[levelindex].id;
                                                                                          sectionlist[10] = sections[sectionindex].id;
                                                                                          daylist[10] = 'tuesday';
                                                                                          subjectlist[10] = subject[sectionindex].id;
                                                                                        });
                                                                                      },
                                                                                    );
                                                                                  },
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
                                                                  padding: const EdgeInsets
                                                                      .all(8.0),
                                                                  child: StreamBuilder(
                                                                      stream: FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                          'Schedule')
                                                                          .doc(level[
                                                                      levelindex]
                                                                          .id)
                                                                          .collection(
                                                                          'Sections')
                                                                          .doc(sections[
                                                                      sectionindex]
                                                                          .id)
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
                                                                                  ],
                                                                                ),
                                                                                StatefulBuilder(
                                                                                  builder: (BuildContext
                                                                                  context,
                                                                                      void Function(void Function())
                                                                                      setState) {
                                                                                    return Checkbox(
                                                                                      value:
                                                                                      checkboxes[11],
                                                                                      onChanged:
                                                                                          (value) {
                                                                                        setState(() {
                                                                                          checkboxes[11] = !checkboxes[11];
                                                                                          levellist[11] = level[levelindex].id;
                                                                                          sectionlist[11] = sections[sectionindex].id;
                                                                                          daylist[11] = 'tuesday';
                                                                                          subjectlist[11] = subject[sectionindex].id;
                                                                                        });
                                                                                      },
                                                                                    );
                                                                                  },
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
                                                                          'Schedule')
                                                                          .doc(level[
                                                                      levelindex]
                                                                          .id)
                                                                          .collection(
                                                                          'Sections')
                                                                          .doc(sections[
                                                                      sectionindex]
                                                                          .id)
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
                                                                                  ],
                                                                                ),
                                                                                StatefulBuilder(
                                                                                  builder: (BuildContext
                                                                                  context,
                                                                                      void Function(void Function())
                                                                                      setState) {
                                                                                    return Checkbox(
                                                                                      value:
                                                                                      checkboxes[12],
                                                                                      onChanged:
                                                                                          (value) {
                                                                                        setState(() {
                                                                                          checkboxes[12] = !checkboxes[12];
                                                                                          levellist[12] = level[levelindex].id;
                                                                                          sectionlist[12] = sections[sectionindex].id;
                                                                                          daylist[12] = 'wednesday';
                                                                                          subjectlist[12] = subject[sectionindex].id;
                                                                                        });
                                                                                      },
                                                                                    );
                                                                                  },
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
                                                                          'Schedule')
                                                                          .doc(level[
                                                                      levelindex]
                                                                          .id)
                                                                          .collection(
                                                                          'Sections')
                                                                          .doc(sections[
                                                                      sectionindex]
                                                                          .id)
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
                                                                                  ],
                                                                                ),
                                                                                StatefulBuilder(
                                                                                  builder: (BuildContext
                                                                                  context,
                                                                                      void Function(void Function())
                                                                                      setState) {
                                                                                    return Checkbox(
                                                                                      value:
                                                                                      checkboxes[13],
                                                                                      onChanged:
                                                                                          (value) {
                                                                                        setState(() {
                                                                                          checkboxes[13] = !checkboxes[13];
                                                                                          levellist[13] = level[levelindex].id;
                                                                                          sectionlist[13] = sections[sectionindex].id;
                                                                                          daylist[13] = 'wednesday';
                                                                                          subjectlist[13] = subject[sectionindex].id;
                                                                                        });
                                                                                      },
                                                                                    );
                                                                                  },
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
                                                                          'Schedule')
                                                                          .doc(level[
                                                                      levelindex]
                                                                          .id)
                                                                          .collection(
                                                                          'Sections')
                                                                          .doc(sections[
                                                                      sectionindex]
                                                                          .id)
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
                                                                                  ],
                                                                                ),
                                                                                StatefulBuilder(
                                                                                  builder: (BuildContext
                                                                                  context,
                                                                                      void Function(void Function())
                                                                                      setState) {
                                                                                    return Checkbox(
                                                                                      value:
                                                                                      checkboxes[14],
                                                                                      onChanged:
                                                                                          (value) {
                                                                                        setState(() {
                                                                                          checkboxes[14] = !checkboxes[14];
                                                                                          levellist[14] = level[levelindex].id;
                                                                                          sectionlist[14] = sections[sectionindex].id;
                                                                                          daylist[14] = 'wednesday';
                                                                                          subjectlist[14] = subject[sectionindex].id;
                                                                                        });
                                                                                      },
                                                                                    );
                                                                                  },
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
                                                                          'Schedule')
                                                                          .doc(level[
                                                                      levelindex]
                                                                          .id)
                                                                          .collection(
                                                                          'Sections')
                                                                          .doc(sections[
                                                                      sectionindex]
                                                                          .id)
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
                                                                                  ],
                                                                                ),
                                                                                StatefulBuilder(
                                                                                  builder: (BuildContext
                                                                                  context,
                                                                                      void Function(void Function())
                                                                                      setState) {
                                                                                    return Checkbox(
                                                                                      value:
                                                                                      checkboxes[15],
                                                                                      onChanged:
                                                                                          (value) {
                                                                                        setState(() {
                                                                                          checkboxes[15] = !checkboxes[15];
                                                                                          levellist[15] = level[levelindex].id;
                                                                                          sectionlist[15] = sections[sectionindex].id;
                                                                                          daylist[15] = 'thursday';
                                                                                          subjectlist[15] = subject[sectionindex].id;
                                                                                        });
                                                                                      },
                                                                                    );
                                                                                  },
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
                                                                          'Schedule')
                                                                          .doc(level[
                                                                      levelindex]
                                                                          .id)
                                                                          .collection(
                                                                          'Sections')
                                                                          .doc(sections[
                                                                      sectionindex]
                                                                          .id)
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
                                                                                  ],
                                                                                ),
                                                                                StatefulBuilder(
                                                                                  builder: (BuildContext
                                                                                  context,
                                                                                      void Function(void Function())
                                                                                      setState) {
                                                                                    return Checkbox(
                                                                                      value:
                                                                                      checkboxes[16],
                                                                                      onChanged:
                                                                                          (value) {
                                                                                        setState(() {
                                                                                          checkboxes[16] = !checkboxes[16];
                                                                                          levellist[16] = level[levelindex].id;
                                                                                          sectionlist[16] = sections[sectionindex].id;
                                                                                          daylist[16] = 'thursday';
                                                                                          subjectlist[16] = subject[sectionindex].id;
                                                                                        });
                                                                                      },
                                                                                    );
                                                                                  },
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
                                                                          'Schedule')
                                                                          .doc(level[
                                                                      levelindex]
                                                                          .id)
                                                                          .collection(
                                                                          'Sections')
                                                                          .doc(sections[
                                                                      sectionindex]
                                                                          .id)
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
                                                                                  ],
                                                                                ),
                                                                                StatefulBuilder(
                                                                                  builder: (BuildContext
                                                                                  context,
                                                                                      void Function(void Function())
                                                                                      setState) {
                                                                                    return Checkbox(
                                                                                      value:
                                                                                      checkboxes[17],
                                                                                      onChanged:
                                                                                          (value) {
                                                                                        setState(() {
                                                                                          checkboxes[17] = !checkboxes[17];
                                                                                          levellist[17] = level[levelindex].id;
                                                                                          sectionlist[17] = sections[sectionindex].id;
                                                                                          daylist[17] = 'thursday';
                                                                                          subjectlist[17] = subject[sectionindex].id;
                                                                                        });
                                                                                      },
                                                                                    );
                                                                                  },
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
                                          ]));
                              },
                            );
                          },
                        );
                      },
                    );
                  }),
            ),
          ),
          Center(
            child: Container(
              height: 50,
              width: 400,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 44, 75, 143)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        side: BorderSide(
                          color: Color.fromARGB(255, 44, 75, 143),
                        ),
                      ),
                    ),
                  ),
                  child: const Text('submit'),
                  onPressed: () async {
                    Registration(context, widget.studentid, checkboxes,
                        levellist, sectionlist, daylist, subjectlist);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
