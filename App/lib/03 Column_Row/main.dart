import 'package:flutter/material.dart';

// void main() {
//   final col = Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [Text("レモン"), Text("リンゴ"), Text("ブドウ")],
//   );
//   final a = MaterialApp(
//     home: Scaffold(body: Center(child: col)),
//   );
//   runApp(a);
// }

// void main() {
//   final col = Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [Text("レモン"), Text("リンゴ"), Text("ブドウ")],
//   );
//   final a = MaterialApp(
//     home: Scaffold(body: Center(child: col)),
//   );
//   runApp(a);
// }

void main() {
  final col = Column(
    mainAxisSize: MainAxisSize.min,
    children: [Text("レモン"), Text("リンゴ"), Text("ブドウ")],
  );
  final a = MaterialApp(
    home: Scaffold(body: Center(child: col)),
  );
  runApp(a);
}
