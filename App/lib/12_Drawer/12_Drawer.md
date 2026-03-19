# Drawer の基礎

## Drawer とは

画面の左（または右）からスワイプして開くサイドメニュー。
`Scaffold` の `drawer` プロパティに設定する。

---

## ファイル構成

```
lib/
└── 12_Drawer/
    ├── main.dart       ← Scaffold にDrawerを設定
    └── side_menu.dart  ← サイドメニューの中身
```

---

## コード全体

### main.dart

```dart
import 'package:flutter/material.dart';
import 'package:project/12_Drawer/side_menu.dart';

void main() {
  final appBar = AppBar(
    title: const Text('appBar'),
  );

  // 左から開くドロワー
  const drawer = Drawer(
    child: SideMenu(),
  );

  // 右から開くドロワー
  const endDrawer = Drawer(
    child: SideMenu(),
  );

  // フローティングアクションボタン
  final fab = FloatingActionButton(
    onPressed: () {
      debugPrint('FAB が押されました');
    },
    child: const Text('FAB'),
  );

  final scaffold = Scaffold(
    appBar: appBar,
    drawer: drawer,               // 左のドロワー
    endDrawer: endDrawer,         // 右のドロワー
    floatingActionButton: fab,    // 右下のボタン
    body: const Center(
      child: Text('body'),
    ),
  );

  final app = MaterialApp(
    debugShowCheckedModeBanner: false, // デバッグバナーを非表示
    home: scaffold,
  );

  runApp(app);
}
```

### side_menu.dart

```dart
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DrawerHeader(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.all(0),
          child: Container(
            color: Colors.blue,
            alignment: Alignment.center,
            child: const Text('DrawerHeader'),
          ),
        ),
        ListTile(
          title: const Text('ListTile A'),
          onTap: () {
            debugPrint('リストタイル A をタップしました');
          },
        ),
        ListTile(
          title: const Text('ListTile B'),
          onTap: () {
            debugPrint('リストタイル B をタップしました');
          },
        ),
        ListTile(
          title: const Text('ListTile C'),
          onTap: () {
            debugPrint('リストタイル C をタップしました');
          },
        ),
      ],
    );
  }
}
```

---

## 各パーツの解説

### Scaffold のプロパティ一覧

```
Scaffold
├── appBar        → 上部のバー
├── drawer        → 左から開くサイドメニュー
├── endDrawer     → 右から開くサイドメニュー
├── floatingActionButton → 右下に浮くボタン（FAB）
└── body          → メインコンテンツ
```

---

### drawer と endDrawer の違い

| プロパティ | 開く方向 | 開き方 |
|-----------|---------|--------|
| `drawer` | 左から | 左端からスワイプ or AppBarの☰アイコン |
| `endDrawer` | 右から | 右端からスワイプ |

---

### DrawerHeader

```dart
DrawerHeader(
  padding: const EdgeInsets.all(0),
  margin: const EdgeInsets.all(0),
  child: Container(
    color: Colors.blue,
    alignment: Alignment.center,
    child: const Text('DrawerHeader'),
  ),
)
```

ドロワーの上部に表示するヘッダー部分。
デフォルトで高さ約160pxが設定されている。
サイズを細かく変えたい場合は `DrawerHeader` を使わず `Container` だけにする。

---

### ListTile

```dart
ListTile(
  title: const Text('ListTile A'),
  onTap: () {
    debugPrint('タップしました');
  },
)
```

リストの1行分のメニュー項目。
`onTap` でタップ時の処理を書く。

**主なプロパティ：**

| プロパティ | 説明 |
|-----------|------|
| `title` | メインのテキスト |
| `leading` | 左側に表示するWidget（アイコンなど） |
| `trailing` | 右側に表示するWidget |
| `tileColor` | 背景色 |
| `onTap` | タップしたときの処理 |

---

### FloatingActionButton（FAB）

```dart
FloatingActionButton(
  onPressed: () {
    debugPrint('FAB が押されました');
  },
  child: const Text('FAB'),
)
```

画面右下に浮いて表示されるボタン。
メインのアクション（追加・投稿など）に使うことが多い。

---

### debugShowCheckedModeBanner

```dart
MaterialApp(
  debugShowCheckedModeBanner: false, // 右上の"DEBUG"バナーを消す
)
```

開発中に右上に表示される `DEBUG` バナーを非表示にできる。

---

## Widget の入れ子構造

```
MaterialApp
└── Scaffold
    ├── AppBar
    ├── Drawer（左）
    │   └── SideMenu
    │       └── ListView
    │           ├── DrawerHeader
    │           │   └── Container（青）
    │           ├── ListTile A
    │           ├── ListTile B
    │           └── ListTile C
    ├── Drawer（右）← endDrawer
    │   └── SideMenu（同じ内容）
    ├── FloatingActionButton
    └── Center
        └── Text('body')
```

---

## ポイントまとめ

- `drawer` → 左から、`endDrawer` → 右から開くサイドメニュー
- サイドメニューの中身は別ファイル（`SideMenu`）に分けると管理しやすい
- `DrawerHeader` のサイズを細かく変えたいときは `Container` に置き換える
- `ListTile` はメニュー項目を手軽に作れる Widget
- `debugShowCheckedModeBanner: false` でデバッグバナーを消せる