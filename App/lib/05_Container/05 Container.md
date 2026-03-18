# Column / Container の基礎

## コード全体

```dart
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
      con2,
    ],
  );

  //コンテナ
  final con = Container(
    color: const Color.fromARGB(255, 255, 128, 128),
    width: 400,
    height: 500,
    padding: EdgeInsets.all(20),
    child: col,
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
```

---

## Widget の入れ子構造

```
MaterialApp
└── Scaffold
    └── Center
        └── Container（赤・400×500）← con
            └── Column ← col
                ├── Container（緑・50×50）← con2
                ├── Container（緑・50×50）← con2
                └── Container（緑・50×50）← con2
```

---

## 各パーツの説明

### con2（小さい緑のコンテナ）

```dart
final con2 = Container(
  color: const Color.fromARGB(221, 99, 255, 125),
  width: 50,
  height: 50,
);
```

| プロパティ | 説明 |
|-----------|------|
| `color` | 背景色。`Color.fromARGB(透明度, R, G, B)` で指定 |
| `width` | 横幅（px） |
| `height` | 縦幅（px） |

---

### col（Column）

```dart
final col = Column(
  mainAxisSize: MainAxisSize.min,
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [con2, con2, con2],
);
```

Columnは子Widgetを**縦に並べる**Widget。

| プロパティ | 値 | 説明 |
|-----------|-----|------|
| `mainAxisSize` | `MainAxisSize.min` | Columnの縦サイズを子要素の合計に合わせる（広げない） |
| `mainAxisAlignment` | `MainAxisAlignment.spaceAround` | 縦方向の並び方。子要素の周りに均等なスペースを入れる |
| `crossAxisAlignment` | `CrossAxisAlignment.start` | 横方向の揃え方。左寄せにする |
| `children` | `[con2, con2, con2]` | 並べる子Widget のリスト |

#### mainAxisAlignment の種類

| 値 | 並び方 |
|----|--------|
| `start` | 上寄せ |
| `center` | 中央 |
| `end` | 下寄せ |
| `spaceBetween` | 両端に配置し、間を均等に空ける |
| `spaceAround` | 子要素の周りに均等なスペース |
| `spaceEvenly` | すべての間隔を均等に空ける |

---

### con（大きい赤のコンテナ）

```dart
final con = Container(
  color: const Color.fromARGB(255, 255, 128, 128),
  width: 400,
  height: 500,
  padding: EdgeInsets.all(20),
  child: col,
);
```

| プロパティ | 説明 |
|-----------|------|
| `color` | 背景色（赤） |
| `width` / `height` | コンテナのサイズ |
| `padding` | 内側の余白。`EdgeInsets.all(20)` は上下左右すべて20px |
| `child` | 子Widget。ここにColumnを入れている |

> **子要素が親要素いっぱいに広がってしまう場合**は、`alignment` で配置場所を指定するか、Column の `mainAxisSize: MainAxisSize.min` を使う。

---

## ポイントまとめ

- `Container` は**サイズ・色・余白・配置**を設定できる汎用Widget
- `Column` は子Widgetを**縦に並べる**Widget
- `mainAxisAlignment` → **並ぶ方向**（Columnなら縦）の揃え方
- `crossAxisAlignment` → **並ぶ方向と垂直**（Columnなら横）の揃え方
- `padding` → 内側の余白、`margin` → 外側の余白