import 'package:flutter/material.dart';

class Accordion extends StatelessWidget {
  const Accordion({
    super.key,
    required this.headColor,
    required this.bodyColor,
    required this.title,
    required this.imageName,
  });
  final Color headColor;
  final Color bodyColor;
  final String title;
  final String imageName;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedTextColor: Colors.white,
      textColor: Colors.white,
      collapsedIconColor: Colors.white,
      iconColor: Colors.white,
      collapsedBackgroundColor: headColor,
      backgroundColor: headColor,
      title: Text(
        title,
        style: const TextStyle(fontSize: 20),
      ),
      children: [
        Container(
          color: bodyColor,
          width: double.infinity,
          height: 100,
          alignment: Alignment.center,
          child: Image.asset(imageName),
        ),
      ],
    );
  }
}
