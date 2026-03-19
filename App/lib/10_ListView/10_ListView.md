# ListView の基礎

## ListView とは

スクロールできるリストを表示するための Widget。
大量のデータを縦に並べて表示するときに使う。

---

## 今回作るもの

ツイッターのタイムラインのようなリストUI。
アイコン・名前・日時・本文を1セットとして、複数件表示する。

---

## コード全体

```dart
import 'package:flutter/material.dart';

// ツイート
class Tweet {
  final String userName;  // ユーザーの名前
  final String iconUrl;   // アイコン画像
  final String text;      // 文章メッセージ
  final String createdAt; // 送信日時

  // コンストラクタ
  Tweet(this.userName, this.iconUrl, this.text, this.createdAt);
}

// データ一覧
final models = [
  Tweet('ルフィ', 'icon1.png', '海賊王におれはなる！', '2022/1/1'),
  Tweet('ゾロ', 'icon2.png', 'おれはもう！二度と敗けねェから！', '2022/1/2'),
  // ...省略
];

// Tweet モデルを Widget に変換する関数
Widget modelToWidget(Tweet model) {
  final icon = Container(
    margin: const EdgeInsets.all(20),
    width: 60,
    height: 60,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Image.asset('assets/images/${model.iconUrl}'),
    ),
  );

  final metaText = Container(
    padding: const EdgeInsets.all(6),
    height: 40,
    alignment: Alignment.centerLeft,
    child: Text(
      '${model.userName}    ${model.createdAt}',
      style: const TextStyle(color: Colors.grey),
    ),
  );

  final text = Container(
    padding: const EdgeInsets.all(8),
    alignment: Alignment.centerLeft,
    child: Text(
      model.text,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
  );

  return Container(
    padding: const EdgeInsets.all(1),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.blue),
      color: Colors.white,
    ),
    width: double.infinity,
    height: 120,
    child: Row(
      children: [
        icon,
        Expanded(
          child: Column(
            children: [metaText, text],
          ),
        ),
      ],
    ),
  );
}

void main() {
  final list = ListView.builder(
    itemCount: models.length,
    itemBuilder: (c, i) => modelToWidget(models[i]),
  );

  final con = Center(
    child: SizedBox(
      height: 400,
      child: list,
    ),
  );

  final sca = Scaffold(
    backgroundColor: Colors.grey,
    body: con,
  );

  runApp(MaterialApp(home: sca));
}
```

---

## 各パーツの解説

### クラスとコンストラクタ

```dart
class Tweet {
  final String userName;
  final String iconUrl;
  final String text;
  final String createdAt;

  Tweet(this.userName, this.iconUrl, this.text, this.createdAt);
}
```

データをまとめて扱うためのクラス。
コンストラクタに値を渡すことでインスタンスを作れる。

```dart
Tweet('ルフィ', 'icon1.png', '海賊王におれはなる！', '2022/1/1')
```

---

### ListView.builder

```dart
final list = ListView.builder(
  itemCount: models.length,       // リストの件数
  itemBuilder: (c, i) => modelToWidget(models[i]), // i番目のデータをWidgetに変換
);
```

| プロパティ | 説明 |
|-----------|------|
| `itemCount` | リストの総件数 |
| `itemBuilder` | インデックス `i` を受け取り、対応する Widget を返す関数 |

> `ListView.builder` は画面に表示される分だけ Widget を生成するので、大量データでも軽い。

---

### ClipRRect（画像を丸くする）

```dart
ClipRRect(
  borderRadius: BorderRadius.circular(30.0),
  child: Image.asset('assets/images/${model.iconUrl}'),
)
```

子 Widget を角丸でクリッピング（切り抜き）する Widget。
`borderRadius` を画像の半分のサイズにすると完全な円になる。

---

### Expanded

```dart
Expanded(
  child: Column(
    children: [metaText, text],
  ),
)
```

Row や Column の中で、残りのスペースをすべて使って広がる Widget。
アイコンの横の残りスペースをテキスト部分で埋めるために使っている。

---

## Widget の入れ子構造

```
MaterialApp
└── Scaffold（背景グレー）
    └── Center
        └── SizedBox（height: 400）
            └── ListView.builder
                └── Container（青枠・height: 120）× 件数分
                    └── Row
                        ├── Container（アイコン・60×60・丸型）
                        │   └── ClipRRect
                        │       └── Image.asset
                        └── Expanded
                            └── Column
                                ├── Container（名前・日時）
                                └── Container（本文）
```

---

## ポイントまとめ

- `ListView.builder` は件数が多いときに使う（効率的）
- `itemBuilder` の `i` がインデックス番号。`models[i]` で対応データを取得する
- `ClipRRect` で画像を丸くできる
- `Expanded` で Row/Column の残りスペースを埋められる
- データとUIを分離するために `modelToWidget()` のような変換関数を作ると管理しやすい