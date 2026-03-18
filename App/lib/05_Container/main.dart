import 'package:flutter/material.dart';

void main() {
  final img = Image.asset(
    'images/apple.png',
  );

  //別のコンテナ
  final con2 = Container(
    color: const Color.fromARGB(221, 99, 255, 125),
    width: 50,
    height: 50,
  );

  //カラム（縦）
  final col = Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      con2,
      con2,
      img,
    ],
  );
  //コンテナ
  final con = Container(
    color: const Color.fromARGB(255, 255, 128, 128),
    width: 400,
    height: 500,
    // alignment: Alignment.topLeft,
    padding: EdgeInsets.all(20),
    // child: con2,
    child: col,
    //子要素を親要素の大きさにしないためには場所を指定してあげる
  );

  //表示
  final a = MaterialApp(
    home: Scaffold(
      body: Center(
        child: con,
      ),
    ),
  );

  runApp(a);
}
