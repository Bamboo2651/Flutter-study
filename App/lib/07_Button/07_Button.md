# 関数と ElevatedButton の基礎

## 今回のコード

```dart
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
```

---

## 関数の種類

### 1. 普通の関数

名前をつけて定義する関数。あとから名前で呼び出せる。

```dart
xxxx() {
  debugPrint('これから通信を始めます');
  debugPrint('通信中です');
  debugPrint('通信が終わりました');
}

// 呼び出し方
xxxx();
```

### 2. 無名関数

名前のない関数。その場で直接渡すときに使う。

```dart
onPressed: () {
  debugPrint('これから通信を始めます');
  debugPrint('通信中です');
  debugPrint('通信が終わりました');
}
```

### 3. アロー関数

処理が1行のときに使える省略記法。

```dart
// 通常の書き方
xxxx() {
  debugPrint('Hello');
}

// アロー関数で書くと
xxxx() => debugPrint('Hello');
```

### 使い分けまとめ

| 種類 | 使うタイミング |
|------|--------------|
| 普通の関数 | 処理が複数行・何度も呼び出す |
| 無名関数 | その場限りの処理を直接渡す |
| アロー関数 | 処理が1行だけのとき |

---

## ElevatedButton の解説

```dart
final button = ElevatedButton(
  onPressed: xxxx,
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 255, 252, 227),
  ),
  child: const Text('押してみて'),
);
```

| プロパティ | 説明 |
|-----------|------|
| `onPressed` | ボタンを押したときに呼ぶ関数を指定する |
| `style` | ボタンの見た目を設定する |
| `backgroundColor` | ボタンの背景色 |
| `child` | ボタンの中に表示するWidget |

> `onPressed: xxxx` は関数を**渡している**だけ。`xxxx()` と書くと**その場で実行**してしまうので注意。

---

## debugPrint とは

```dart
debugPrint('通信中です');
```

VSCode のターミナルにテキストを出力する。
`print()` と似ているが、Flutter では `debugPrint()` の方が推奨されている。
実際の画面には表示されない。動作確認やデバッグのときに使う。

---

## Widget の入れ子構造

```
MaterialApp
└── Scaffold
    └── Center
        └── ElevatedButton
            └── Text('押してみて')
```

---

## ポイントまとめ

- `onPressed` には関数を**名前だけ**渡す（`xxxx` ✅ / `xxxx()` ❌）
- 処理が1行なら**アロー関数**、複数行なら**普通の関数か無名関数**
- `debugPrint` はターミナルへの出力。デバッグ確認に使う
- ボタンの色は `style: ElevatedButton.styleFrom()` の中に書く