import 'package:flutter/material.dart';

void main() {
  final img = Image.asset(
    'images/apple_kajiru.png',
  );

  final row = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [img, img, img],
  );

  final a = MaterialApp(
    home: Scaffold(
      body: Center(
        child: row,
      ),
    ),
  );

  runApp(a);
}
