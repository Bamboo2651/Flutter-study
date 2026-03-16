import 'package:flutter/material.dart';

void main() {
  const b = "バナナ";
  const t = Text(b);
  const c = Center(child: t);
  const s = Scaffold(body: c);
  const a = MaterialApp(home: s);
  runApp(a);
}

// こんな書き方もある
// void main() {
//   const a = MaterialApp(
//     home: Scaffold(body: Center(child: Text("バナナ"))),
//   );
//   runApp(a);
// }
