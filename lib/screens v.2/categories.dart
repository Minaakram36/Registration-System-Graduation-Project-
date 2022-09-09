import 'package:flutter/material.dart';
import 'package:registrationsystem/screens v.2/signin.dart';
import 'package:registrationsystem/screens%20v.2/profile.dart';
import 'category_item.dart';
import 'dummy_data.dart';

class ScreenCategories extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 44, 75, 143),
        title: Text("Hello , " + Nameoftheuser!.split(" ").first.toString()),
        leading: IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileScreen()));
          },
        ),
        actions: <Widget>[
          const Icon(
            Icons.exit_to_app,
            size: 23.0,
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Signin()));
            },
            child: const Text(
              'Sign Out',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: const Color.fromARGB(255, 169, 177, 194),
          child: Center(
            child: GridView(
              padding: const EdgeInsets.all(25),
              children: DUMMY_CATEGORIES
                  .map(
                    (categoryData) => CategoryItem(categoryData.title,
                    categoryData.icon, categoryData.color),
              )
                  .toList(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 4 / 4,
                crossAxisSpacing: 30,
                mainAxisSpacing: 120,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
