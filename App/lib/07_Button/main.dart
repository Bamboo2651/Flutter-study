import 'package:flutter/material.dart';

void main() {
  // ボタンを押したら呼ばれる関数
  xxxx() {
    debugPrint('これから通信を始めます');
    debugPrint('通信中です');
    debugPrint('通信が終わりました');
  }

  // ボタン本体
  final button = ElevatedButton(
    onPressed: xxxx,
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 255, 252, 227),
    ),
    child: const Text('押してみて'),
  );

  // アプリ
  final a = MaterialApp(
    home: Scaffold(
      body: Center(
        child: button,
      ),
    ),
  );

  runApp(a);
}
