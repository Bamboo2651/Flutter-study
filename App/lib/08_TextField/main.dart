import 'package:flutter/material.dart';

void main() {
  final controller = TextEditingController();

  final textField = TextField(
    controller: controller,

    //デコレーション
    decoration: const InputDecoration(
      border: OutlineInputBorder(), //周りに線を引く
      labelText: "あなたの名前", //プレースホルダ
      hintText: "カタカナで入力してください", //アクティブ状態のプレースホルダ
      errorText: null, //エラーが出る
    ),
  );

  // 関数
  xxxx() {
    // コントローラーから文字を取り出して確認
    debugPrint(controller.text);
  }

  // ボタン
  final button = ElevatedButton(
    // 関数を このボタンに結びつけておく
    onPressed: xxxx,
    child: const Text('ボタンです'),
  );

  // アプリ
  final app = MaterialApp(
    // 画面
    home: Scaffold(
      // 真ん中
      body: Center(
        // 縦に並べる
        child: Column(
          // いい感じにスペース開ける
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // コンテナ
            SizedBox(
              width: 300, // 横幅
              child: textField, // テキストフィールド
            ),
            // ボタンをおく
            button,
          ],
        ),
      ),
    ),
  );

  // アプリを動かす
  runApp(app);
}
