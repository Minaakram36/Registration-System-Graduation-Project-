// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

import 'category.dart';

const DUMMY_CATEGORIES = [
  Category(
    title: 'Compeleted Courses',
    icon: Icon(
      Icons.done,
      size: 50.0,
      color: Colors.lightGreen,
    ),
    color: Colors.white,
  ),
  Category(
    title: 'In Progress Courses',
    icon: Icon(
      Icons.wifi_protected_setup_sharp,
      color: Colors.blue,
      size: 50.0,
    ),
    color: Colors.white,
  ),
  Category(
    title: 'Failed Courses',
    icon: Icon(
      Icons.list_alt_sharp,
      color: Colors.redAccent,
      size: 50.0,
    ),
    color: Colors.white,
  ),
  Category(
    title: 'About',
    icon: Icon(
      Icons.info_outline,
      size: 50.0,
      color: Color.fromARGB(255, 94, 12, 109),
    ),
    color: Colors.white,
  ),
  Category(
    title: 'Schedule',
    icon: Icon(
      Icons.schedule,
      size: 50.0,
      color: Color.fromARGB(255, 12, 64, 109),
    ),
    color: Colors.white,
  ),
  Category(
    title: 'Announcement',
    icon: Icon(
      Icons.announcement,
      size: 50.0,
      color: Color.fromARGB(255, 94, 12, 109),
    ),
    color: Colors.white,
  ),
];