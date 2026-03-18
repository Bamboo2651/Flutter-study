# 03 Widget の基礎

## 前回の復習

```bash
flutter create 名前
```

---

## 今回のテーマ：Widget の基礎

### Flutter の基本

- Flutter は **Dart** で書く
- プログラムの起点は **main 関数**

```dart
void main() {

}
```

- Flutter は **Widget** でほとんどできている

---

### Widget とは

画面に表示されるすべての部品のこと。
テキスト・ボタン・画像・レイアウトなど、Flutter の画面はすべて Widget を組み合わせて作られている。
HTMLで言う「タグ」に近いイメージ。

#### Widget 一覧

| Widget | 役割 | 例 |
|--------|------|----|
| `Text` | テキストを表示する | `Text("こんにちは")` |
| `Center` | 子 Widget を中央に配置する | `Center(child: Text("hello"))` |
| `Scaffold` | 画面の土台。AppBar や body を置く枠組み | `Scaffold(body: ...)` |
| `MaterialApp` | アプリ全体を包む。マテリアルデザインを適用する | `MaterialApp(home: ...)` |
| `Container` | 余白・サイズ・背景色などを設定できる箱 | `Container(color: Colors.red)` |
| `Column` | Widget を縦に並べる | `Column(children: [...])` |
| `Row` | Widget を横に並べる | `Row(children: [...])` |
| `Image` | 画像を表示する | `Image.network("URL")` |
| `Icon` | アイコンを表示する | `Icon(Icons.star)` |
| `ElevatedButton` | タップできるボタン | `ElevatedButton(onPressed: ..., child: ...)` |

---

## コードの説明

```dart
import 'package:flutter/material.dart';

void main() {
  const b = "バナナ";
  const t = Text(b);
  const c = Center(child: t);
  const s = Scaffold(body: c);
  const a = MaterialApp(home: s);
  runApp(a);
}
```

| コード | 説明 |
|--------|------|
| `const b = "バナナ"` | 「バナナ」という文字を `b` という変数に格納 |
| `const t = Text(b)` | `b` をテキスト Widget にする |
| `const c = Center(child: t)` | テキストを画面中央に配置する |
| `const s = Scaffold(body: c)` | アプリの画面の土台。AppBar（上部バー）や body（メインコンテンツ）などを置く枠組み |
| `const a = MaterialApp(home: s)` | Scaffold をアプリとして包む。マテリアルデザインのテーマを適用する |
| `runApp(a)` | アプリを起動・実行する |

### Widget の入れ子構造（イメージ）

```
MaterialApp
└── Scaffold
    └── Center
        └── Text("バナナ")
```

---

## トラブルシューティング

### Chrome でエラーが出たとき

以下の2つを順番に実行すると直ることがある。

```bash
flutter clean
flutter run -d chrome
```