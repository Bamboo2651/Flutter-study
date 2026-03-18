stlesswidgetを学ぶ
今回はこんな感じのを作る
![完成品](image.png)


まず最初にdartを書くための
import 'package:flutter/material.dart';
これを書く。

次に「stless」と入力し選択すると
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
が出てくる。Widgetをつくるのに使う
「MyWidget」のところを自分の作りたいWidgetの名前にする。
widgetのコードはWidget buildの中に書いていく。

バナナの画像と、カウンターのテキストを用意する。

// バナナの画像
final banana = Image.asset(
  'images/06/banana.png',
  width: 40,
  height: 40,
);

// 数字の部分
final text = Text(
  '$number',
  style: const TextStyle(
    color: Colors.yellow, // 文字の色
    fontSize: 50, // 文字の大きさ
  ),
);

バナナとテキストを横に並べる
// 横に並べる
final row = Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    banana,
    text,
  ],
);

コンテナの中に表示する
// 色と大きさを決める
final con = Container(
  width: 300, // 横幅
  height: 100, // 高さ
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: Colors.black87, // 背景の色
    borderRadius: BorderRadius.circular(12), // 角を少し丸くする
  ),
  child: row,
);

表示するWidget
return con;