import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class Database extends StatefulWidget {

  const Database({Key? key}) : super(key: key);

  @override
  State<Database> createState() => DatabaseState();
}

class DatabaseState extends State<Database> {

  @override
  Widget build(BuildContext context) {

    return Container();
  }
}

//Done
void createuseraccount(context ,String userid,String name,String birthdate,String gender, String phone,String email)async{

DocumentSnapshot checkdoc = await FirebaseFirestore.instance.collection('Users').doc(userid).get();
 if(checkdoc.exists){
   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
     content: Text('User for this id already Exists'),
   ));
 }
else {
   await FirebaseFirestore.instance.collection('Users')
       .doc(userid).set({
     'Birthdate': birthdate,
     'GPA': 0,
     'List': userid.substring(0,3),
     'Name': name,
     'Password': userid,
     'Phone': phone,
     'Email': email,
     'Totalhours':0 ,
     'Earnedhours':0 ,
     'Semestergpa':0,
     'Image': '',
     'Department':'',
     'Gender':gender

   });
   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
     content: Text('User added Successfully'),
   ));
 }
}
void updateuserinfo(context,String userid,{String? name,String? birthdate,String? listofcourse, String? phone ,double? gpa,String? password,int? totalhours,double? Semestergpa})async{

 Map<String,Object?> list =new Map<String,Object?>();
 if(name!=null)
   {
    list['Name']=name;
   }
 if(birthdate != null)
 {
   list['Birthdate']=birthdate;
 }
 if(listofcourse!=null)
 {
   list['List']=listofcourse;
 }
 if(phone!=null)
 {
   list['Phone']=phone;
 }
 if(gpa!=null)
 {
   list['GPA']=gpa;
 }
 if(password!=null)
 {
   list['Password']=password;
 }
 if(password!=null)
 {
   list['Totalhours']=totalhours;
 }
 if(Semestergpa!=null)
 {
   list['Semestergpa']=Semestergpa;
 }
  try{
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(userid).update(
    list
  );
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Information updated Successfully'),
  ));
 }
 catch(error){

   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
   content: Text('User not found'),
 ));}

}
getfailedcourses(context ,String userid) async{


  return showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(

          color: Colors.white,
          child:  StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(userid)
                .collection('Coursesfailed')
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
                    return Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Table(
                                  border: TableBorder.all(
                                    width: 2,
                                  ),
                                  children: [
                                    TableRow(
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(212, 226, 232, 236),
                                        ),
                                        children: [
                                          Center(
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text('${docs[index]['Name']}',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                      )),
                                                ),
                                              )),
                                          Center(
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text('${docs[index].id}',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                      )),
                                                ),
                                              )),
                                          Center(
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text('${docs[index]['Credithoure']}',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                      )),
                                                ),
                                              )),
                                        ]),
                                  ],
                                ),
                              ),
                            ]));
                  });
            },
          )
      );

    },
  );





}



// Semester grades and gpa
void addgrade(context,String userid ,String subject, String grade)async{

  try{
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userid)
        .collection('Courses')
        .doc(subject).update({
      'Grade':grade
    });

  } catch(error){
    DocumentSnapshot checkdoc = await FirebaseFirestore.instance.collection('Users').doc(userid).get();
    if(checkdoc.exists){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Incorrect Subject ID'),
      ));
    }
    else{ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('User not found'),
    ));}
  }
}
void calculatesemestergpa(context,String userid) async {
  final _grades = ['A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'F'];
  final _gradesindouble = [4.0, 3.7, 3.3, 3.0, 2.7, 2.3, 2.0, 1.7, 1.3, 1.0, 0.0];

  double totalGrade=0;
  double totalCredit=0;
  double gpa=0;

  List <double> grades = [];
  List <double> houres = [];

  QuerySnapshot snaphsot = await FirebaseFirestore.instance
      .collection('Users')
      .doc(userid)
      .collection('Courses')
      .get();

  for (var course in snaphsot.docs) {
    if (course['Grade'] != '') {
      grades.add(_gradesindouble[_grades.indexOf(course['Grade'])]);
      houres.add(double.parse(course['Credithoure'].toString()));
    }
  }
  for (int i = 0; i < grades.length; i++){

    totalGrade = totalGrade + (grades[i] * houres[i]);
    totalCredit += houres[i];

  }
  if(double.parse((totalGrade / totalCredit).toStringAsPrecision(3)).isNaN){
    gpa=0;
  }
  else {
    gpa = double.parse((totalGrade / totalCredit).toStringAsPrecision(3));

  }

  await FirebaseFirestore.instance
      .collection('Users')
      .doc(userid).update({
    'Semestergpa': gpa,

  });
  ScaffoldMessenger.of(context).showSnackBar( SnackBar(

    content: Text('Grades has been saved successfully'),
  ));
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: Duration(seconds:1),
    content: Text('Semester GPA updated'),
  ));
}
void addmultiplegrade(context,String userid ,List<String> subject, List<TextEditingController> grade,int doclength)async{
  final _grades = ['','A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'F'];
  try{
    for(int i =0 ; i < doclength;i++) {
      if (_grades.contains(grade[i].text.trim().toUpperCase())) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userid)
            .collection('Courses')
            .doc(subject[i]).update({
          'Grade': grade[i].text.trim().toUpperCase()
        });
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              '${grade[i].text.trim().toUpperCase()} is invalid!!!',
              style: TextStyle(color: Colors.red),
            )));
      }
    }
  } catch(error){
    DocumentSnapshot checkdoc = await FirebaseFirestore.instance.collection('Users').doc(userid).get();
    if(checkdoc.exists){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Incorrect Subject ID'),
      ));
    }
    else{ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('User not found'),
    ));}
  }
  calculatesemestergpa(context,userid);
}


// clear courses and update cgpa
void movecoursestodoneorfail(context,String userid) async{

  QuerySnapshot snaphsot = await FirebaseFirestore.instance
      .collection('Users')
      .doc(userid)
      .collection('Courses')
      .get();

  for (var message in snaphsot.docs) {
    final getdocid = message.id;
    final getcredithoure = message['Credithoure'];
    final getgrade = message['Grade'];
    final getName = message['Name'];
    final getdoctor = message['Doctor'];



    if (getgrade != 'F' &&getgrade != '') {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userid)
          .collection('Coursesdone')
          .doc('$getdocid')
          .set({
        'Name': getName,
        'Credithoure': getcredithoure,
        'Grade': getgrade,
        'Doctor' :getdoctor,

      });
    }
    else if(getgrade == 'F'){
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userid)
          .collection('Coursesfailed')
          .doc('$getdocid')
          .set({
        'Name': getName,
        'Credithoure': getcredithoure,
        'Grade': getgrade,
        'Doctor' :getdoctor,
      });
    }

  }
  calculategpa(context,userid);
}
void calculategpa(context,String userid)async{
  final _grades = ['A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'F'];
  final _gradesindouble = [4.0, 3.7, 3.3, 3.0, 2.7, 2.3, 2.0, 1.7, 1.3, 1.0, 0.0];

  double totalpoints=0.0;
  double earnedhours=0.0;
  double totalhours=0.0;
  double gpa =0.0;
  await FirebaseFirestore.instance.collection('Users').doc(userid).collection('Coursesdone').get().then((snapshot) {
    for (DocumentSnapshot ds in snapshot.docs) {
      totalpoints = totalpoints + ( _gradesindouble[_grades.indexOf(ds['Grade'])] * ds['Credithoure']);
      earnedhours = earnedhours + ds['Credithoure'];
      totalhours  = totalhours  + ds['Credithoure'];
    }

  });
  await FirebaseFirestore.instance.collection('Users').doc(userid).collection('Coursesfailed').get().then((snapshot) {
    for (DocumentSnapshot ds in snapshot.docs) {
      totalpoints = totalpoints + ( _gradesindouble[_grades.indexOf(ds['Grade'])] * ds['Credithoure']);
      totalhours  = totalhours  + ds['Credithoure'];
    }

  });

  gpa = double.parse((totalpoints/totalhours).toStringAsPrecision(3));
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(userid).update({
    'GPA':gpa,
    'Totalhours': totalhours,
    'Earnedhours':earnedhours,
    'Semestergpa':0,
  });
  clearcourses(context,userid);
}
void clearcourses(context,String userid) async{

  await FirebaseFirestore.instance.collection('Users').doc(userid).collection('Courses').get().then((snapshot) {
    for (DocumentSnapshot ds in snapshot.docs){
      if (ds['Grade']!=''){
        ds.reference.delete();
      }
    }
  });
  ScaffoldMessenger.of(context).showSnackBar( SnackBar(

    content: Text('Strudent informations saved successfully'),
  ));
 clearschedule(context, userid);
}
void clearschedule(context,String userid)async{
  await FirebaseFirestore.instance.collection('Users').doc(userid).collection('Schedule').doc('days').collection('saturday').get().then((snapshot) {
    for (DocumentSnapshot ds in snapshot.docs) {
      ds.reference.delete();
    }
  });
  await FirebaseFirestore.instance.collection('Users').doc(userid).collection('Schedule').doc('days').collection('sunday').get().then((snapshot) {
    for (DocumentSnapshot ds in snapshot.docs) {
      ds.reference.delete();
    }
  });
  await FirebaseFirestore.instance.collection('Users').doc(userid).collection('Schedule').doc('days').collection('monday').get().then((snapshot) {
    for (DocumentSnapshot ds in snapshot.docs) {
      ds.reference.delete();
    }
  });
  await FirebaseFirestore.instance.collection('Users').doc(userid).collection('Schedule').doc('days').collection('tuesday').get().then((snapshot) {
    for (DocumentSnapshot ds in snapshot.docs) {
      ds.reference.delete();
    }
  });
  await FirebaseFirestore.instance.collection('Users').doc(userid).collection('Schedule').doc('days').collection('wednesday').get().then((snapshot) {
    for (DocumentSnapshot ds in snapshot.docs) {
      ds.reference.delete();
    }
  });
  await FirebaseFirestore.instance.collection('Users').doc(userid).collection('Schedule').doc('days').collection('thursday').get().then((snapshot) {
    for (DocumentSnapshot ds in snapshot.docs) {
      ds.reference.delete();
    }
  });
}




//registration
void Registration(context,String userid ,List<bool>checkboxes ,List<String>level,List<String>section,List<String>day,List<String>subject)async {
  var result;

  for (int i = 0; i < 18; i++) {
    if(checkboxes[i]==true){
      result = await FirebaseFirestore.instance.collection('Schedule').doc(level[i])
          .collection('Sections').doc(section[i]).collection(day[i]).doc(
          subject[i])
          .get();
      var fail = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userid)
          .collection('Coursesfailed')
          .doc(result.id)
          .get();
      if(fail.exists) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userid)
            .collection('Coursesfailed')
            .doc(result.id)
            .delete();
        await FirebaseFirestore.instance.collection('Users').doc(userid)
            .collection('Schedule').doc('days').collection(day[i])
            .doc(result.id)
            .set({
          'Name': result['Name'],
          'Credithours': result['Creditshours'],
          'Doctor': result['Doctor'],
          'Type': result['Type'],
          'Room': result['Room'],
          'Time': result['Time'],
        });
      }else {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userid)
            .collection('Schedule')
            .doc('days')
            .collection(day[i])
            .doc(result.id)
            .set({
          'Name': result['Name'],
          'Credithours': result['Creditshours'],
          'Doctor': result['Doctor'],
          'Type': result['Type'],
          'Room': result['Room'],
          'Time': result['Time'],
        });
        if (level[i] == 'level4' &&
            section[i].substring(0, 3) == 'SWA1'.substring(0, 3)) {
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(userid)
              .update({
            'Department': 'Software Engineering',
          });
        }
        if (level[i] == 'level4' &&
            section[i].substring(0, 3) == 'CNEA1'.substring(0, 3)) {
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(userid)
              .update({
            'Department': 'Computer Network',
          });
        }
      }
    }
  }
  ScaffoldMessenger.of(context).showSnackBar( SnackBar(

    content: Text('Schedule saved'),
  ));
  movetoinprogress(userid);
}
void movetoinprogress(String userid)async{
 await FirebaseFirestore.instance.collection('Users').doc(userid).collection('Schedule').doc('days').collection('saturday').where('Type',isEqualTo: 'lecture').get().then((snapshot) {
   for (DocumentSnapshot ds in snapshot.docs){
      FirebaseFirestore.instance
         .collection('Users')
         .doc(userid)
         .collection('Courses')
         .doc(ds.id)
         .set({
        'Name': ds['Name'],
        'Credithoure': ds['Credithours'],
        'Grade': '',
        'Time': ds['Time'],
        'Doctor': ds['Doctor'],
     });
 }});

 await FirebaseFirestore.instance.collection('Users').doc(userid).collection('Schedule').doc('days').collection('sunday').where('Type',isEqualTo: 'lecture').get().then((snapshot) {
   for (DocumentSnapshot ds in snapshot.docs){
     FirebaseFirestore.instance
         .collection('Users')
         .doc(userid)
         .collection('Courses')
         .doc(ds.id)
         .set({
       'Name': ds['Name'],
       'Credithoure': ds['Credithours'],
       'Grade': '',
       'Time': ds['Time'],
       'Doctor': ds['Doctor'],
     });
   }});
await FirebaseFirestore.instance.collection('Users').doc(userid).collection('Schedule').doc('days').collection('monday').where('Type',isEqualTo: 'lecture').get().then((snapshot) {
  for (DocumentSnapshot ds in snapshot.docs){
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userid)
        .collection('Courses')
        .doc(ds.id)
        .set({
      'Name': ds['Name'],
      'Credithoure': ds['Credithours'],
      'Grade': '',
      'Time': ds['Time'],
      'Doctor': ds['Doctor'],
    });
  }});
 await FirebaseFirestore.instance.collection('Users').doc(userid).collection('Schedule').doc('days').collection('tuesday').where('Type',isEqualTo: 'lecture').get().then((snapshot) {
   for (DocumentSnapshot ds in snapshot.docs){
     FirebaseFirestore.instance
         .collection('Users')
         .doc(userid)
         .collection('Courses')
         .doc(ds.id)
         .set({
       'Name': ds['Name'],
       'Credithoure': ds['Credithours'],
       'Grade': '',
       'Time': ds['Time'],
       'Doctor': ds['Doctor'],
     });
   }});
 await FirebaseFirestore.instance.collection('Users').doc(userid).collection('Schedule').doc('days').collection('wednesday').where('Type',isEqualTo: 'lecture').get().then((snapshot) {
   for (DocumentSnapshot ds in snapshot.docs){
     FirebaseFirestore.instance
         .collection('Users')
         .doc(userid)
         .collection('Courses')
         .doc(ds.id)
         .set({
       'Name': ds['Name'],
       'Credithoure': ds['Credithours'],
       'Grade': '',
       'Time': ds['Time'],
       'Doctor': ds['Doctor'],
     });
   }});
await FirebaseFirestore.instance.collection('Users').doc(userid).collection('Schedule').doc('days').collection('thursday').where('Type',isEqualTo: 'lecture').get().then((snapshot) {
  for (DocumentSnapshot ds in snapshot.docs){
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userid)
        .collection('Courses')
        .doc(ds.id)
        .set({
      'Name': ds['Name'],
      'Credithoure': ds['Credithours'],
      'Grade': '',
      'Time': ds['Time'],
      'Doctor': ds['Doctor'],
    });
  }});


}



void StoreJsontoFirebase() async {
 final String response = await rootBundle.loadString('assets/Data.json');
  final data = await json.decode(response);
  List datalist=[];
  datalist=data['testing'];
  datalist.forEach((element) {FirebaseFirestore.instance.collection('Test').doc(element['ID'].toString()).set(
      {
        'Name':element['Name'],
        'Birthdate':element['Birthdate'],
        'Email':element['Email'],
        'Gender':element['Gender'],
        'Phone':element['Phone'],
        'GPA': 0,
        'Totalhours':0 ,
        'Earnedhours':0 ,
        'Semestergpa':0,
        'Image': '',
        'Department':'',
        'List':element['ID'].toString().substring(0,3),
        'Password':element['ID'].toString(),
      });});
}


/*void StoreJsontoFirebase2() async {
  final  response =  await http.post(Uri.parse('https://firebasestorage.googleapis.com/v0/b/registration-system-97c6f.appspot.com/o/json%2Fdata.json?alt=media&token=4ef10666-1315-488e-951c-e7e38b1aa410'));
  final data = await jsonDecode(response.body);
  List datalist=[];
  datalist=data['testing'];
  datalist.forEach((element) {FirebaseFirestore.instance.collection('Test').doc(element['ID'].toString()).set(
      {
        'Name':element['Name'],
        'Birthdate':element['Birthdate'],
        'Email':element['Email'],
        'Gender':element['Gender'],
        'Phone':element['Phone'],
        'GPA': 0,
        'Totalhours':0 ,
        'Earnedhours':0 ,
        'Semestergpa':0,
        'Image': '',
        'Department':'',
        'List':element['ID'].toString().substring(0,3),
        'Password':element['ID'].toString(),
      });});
}*/



/*
void scheduleregistration(context,String userid,List<List<List<bool>>> checkboxes ,List<QueryDocumentSnapshot<Object?>>leveldoc,List<List<List<int>>> level ,List<List<List<String>>> section,List<List<List<QueryDocumentSnapshot>>>subjectdoc)async{
  List<String> day = ['saturday','sunday','monday','tuesday','wednesday','thursday'];
  for(int dayindex=0;dayindex<6;dayindex++){
    for(int timeindex = 0 ;timeindex<3;timeindex++) {
      for (int checkboxindex = 0; checkboxindex < checkboxes[dayindex][timeindex].length;checkboxindex++){
        if(checkboxes[dayindex][timeindex][checkboxindex]==true){
         var result= await FirebaseFirestore.instance.collection('Schedule').doc(leveldoc[level[dayindex][timeindex][checkboxindex]].id).collection('Sections').doc(section[dayindex][timeindex][checkboxindex]).collection(day[dayindex]).doc(subjectdoc[dayindex][timeindex][checkboxindex].id).get();

         var fail = await FirebaseFirestore.instance
             .collection('Users')
             .doc(userid)
             .collection('Coursesfailed')
             .doc(result.id)
             .get();
         if(fail.exists) {
           await FirebaseFirestore.instance
               .collection('Users')
               .doc(userid)
               .collection('Coursesfailed')
               .doc(result.id)
               .delete();

           await FirebaseFirestore.instance.collection('Users').doc(userid)
               .collection('Schedule').doc('days').collection(day[dayindex])
               .doc(result.id)
               .set({
             'Name': result['Name'],
             'Credithours': result['Credithours'],
             'Doctor': result['Doctor'],
             'Type': result['Type'],
             'Room': result['Room'],
             'Time': result['Time'],
           });
         }
         else{await FirebaseFirestore.instance.collection('Users').doc(userid)
             .collection('Schedule').doc('days').collection(day[dayindex])
             .doc(result.id)
             .set({
           'Name': result['Name'],
           'Credithours': result['Credithours'],
           'Doctor': result['Doctor'],
           'Type': result['Type'],
           'Room': result['Room'],
           'Time': result['Time'],
         });}
        }
      }
    }
  }

  ScaffoldMessenger.of(context).showSnackBar( SnackBar(

    content: Text('Schedule saved'),
  ));


  movetoinprogress(userid);

}
*/

/*
void calculatecumulativegpa(String userid) async{

  double cgpa=0.0;
  double semestergpa=0.0;
  double semesterhoure=0.0;
  double totalhoure=0.0;
 // int Semesterfailhours;
 // int Passedhours;
  DocumentSnapshot doc = await FirebaseFirestore.instance.collection('Users').doc(userid).get();

  cgpa=double.parse(doc['GPA'].toString());
  semestergpa=double.parse(doc['Semestergpa'].toString());
  semesterhoure=double.parse(doc['Semesterhoure'].toString());
  totalhoure=double.parse(doc['Totalhours'].toString());
 // Semesterfailhours = doc['Semesterfailhours'];
 // Passedhours =doc['Passedhours'];

  double result = double.parse((((cgpa*totalhoure)+(semestergpa*semesterhoure))/ (totalhoure + semesterhoure)).toStringAsPrecision(3));
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(userid).update({
    'GPA':result,
    'Totalhours': totalhoure+semesterhoure,
    'Semestergpa':0,
    'Semesterfailhours': 0,
    'Semesterhoure':0,
  });
}
*/


/*void f()async{
  QuerySnapshot snaphsot = await FirebaseFirestore.instance
      .collection('Schedule')
      .doc('level4')
      .collection('Sections').doc('SWA1').collection('Wednesday')
      .get();

  for (var message in snaphsot.docs) {
    final getdocid = message.id;
    final getcredithoure = message['Creditshours'];
    final getname = message['Name'];
    final getdoctor = message['Doctor'];
    final gettype = message['Type'];
    final getroom = message['Room'];
    final gettime = message['Time'];




    await FirebaseFirestore.instance
        .collection('Schedule')
        .doc('level4')
        .collection('Sections').doc('SWA1').collection('wednesday').doc(getdocid).set({
      'Name': getname,
      'Creditshours': getcredithoure,
      'Doctor': getdoctor,
      'Type': gettype,
      'Room': getroom,
      'Time': gettime,
    });
  }}*/


/*



Future<String> localPath() async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get localFile async {
  final path = await localPath;
  return File('$path/data.json');
}

Future<String> readdata() async {

    final file = await localFile;

    // Read the file
    final contents = await file.readAsString();
    return contents;
  }*/
