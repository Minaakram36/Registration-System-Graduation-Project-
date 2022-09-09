import 'package:flutter/material.dart';
import 'package:registrationsystem/styles/app_colors.dart';
import 'package:registrationsystem/styles/text_styles.dart';


class CustomHeader extends StatelessWidget {
  final String text;
  final Icon icon;

  final Function()? onTap;
  const CustomHeader(
      {Key? key, required this.text, required this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, left: 16),
      child: Row(
        children: [
          InkWell(
            onTap: onTap,
            child: (icon),
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            text,
            style: KTextStyle.headerTextStyle,
          )
        ],
      ),
    );
  }
}
