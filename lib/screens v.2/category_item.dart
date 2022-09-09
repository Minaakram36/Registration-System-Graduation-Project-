import 'package:flutter/material.dart';

import 'CategoryScreen.dart';

// ignore: camel_case_types
class CategoryItem extends StatelessWidget {
  final String title;
  final Icon icon;
  final Color color;
  CategoryItem(this.title, this.icon, this.color);
  void selectcategory(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(
        builder: (context) => CategoryScreen(categoryTitle: title)));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectcategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        // ignore: deprecated_member_use
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(child: (icon)),
                Text(title, style: Theme.of(context).textTheme.headline6)
              ]),
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [color.withOpacity(0.7), color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
