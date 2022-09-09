import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class studentProfile extends StatefulWidget {

  String studentid;

  studentProfile(this.studentid,{Key? key})
      : super(key: key);

  @override
  State<studentProfile> createState() => _studentProfileState();
}

class _studentProfileState extends State<studentProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student Information ',
        ),
        backgroundColor: const Color.fromARGB(255, 44, 75, 143),
      ),
      body:StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(widget.studentid)
              .snapshots(),
          builder: (ctx, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            final docs = snapshot.data!;

            ImageProvider imagecheck(){
              if(docs['Image']=='') {return
                AssetImage("assets/images/default_image.jpg");
              }
              else return NetworkImage(docs['Image']);}
            return ListView(
              children: <Widget>[
                Container(
                  height: 250,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 44, 75, 143),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.white70,
                            minRadius: 60.0,
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundImage:imagecheck(),
                            ),
                          ),
                        ],
                      ),
                    const  SizedBox(
                        height: 10,
                      ),
                      Text(
                        docs['Name'].toString(),
                        style:const  TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        docs.id.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          color: Color.fromARGB(255, 195, 200, 209),
                          child: ListTile(
                            title: Text(
                              docs['GPA'].toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                            subtitle:const  Text(
                              'Total GPA',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: const Color.fromARGB(255, 83, 109, 165),
                          child: ListTile(
                            title: Text(
                              docs['Earnedhours'].toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: const Text(
                              'Earned Hours',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: const Color.fromARGB(255, 195, 200, 209),
                          child: ListTile(
                            title: Text(
                              docs['Totalhours'].toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                            subtitle:const  Text(
                              'Total Hours',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: const Text(
                          'Email',
                          style: TextStyle(
                            color: Color.fromARGB(255, 44, 75, 143),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          docs['Email'].toString(),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                     const  Divider(),
                      ListTile(
                        title: const Text(
                          'Phone',
                          style: TextStyle(
                            color: Color.fromARGB(255, 44, 75, 143),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          docs['Phone'].toString(),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                     const  Divider(),
                      ListTile(
                        title: const Text(
                          'Birthdate',
                          style: TextStyle(
                            color: Color.fromARGB(255, 44, 75, 143),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          docs['Birthdate'].toString(),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const  Divider(),
                      ListTile(
                        title: const Text(
                          'Department',
                          style: TextStyle(
                            color: Color.fromARGB(255, 44, 75, 143),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          docs['Department'].toString(),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
