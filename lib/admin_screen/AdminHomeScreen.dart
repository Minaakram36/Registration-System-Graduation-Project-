import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'pages/mobile/mobile_screen.dart';

class AdminHomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      return MobileScreen();
    });
  }
}
