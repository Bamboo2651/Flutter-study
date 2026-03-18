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