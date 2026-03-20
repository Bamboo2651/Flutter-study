# BottomNavigationBar の基礎

## BottomNavigationBar とは

画面の下に表示されるナビゲーションバー。
タブを切り替えることで表示する画面を変えられる。

---

## ファイル構成

```
lib/
└── 13_BottomNavigationBar/
    ├── main.dart    ← BarとRiverpodの設定
    ├── page_a.dart  ← 画面A
    ├── page_b.dart  ← 画面B
    └── page_c.dart  ← 画面C
```

---

## コード全体

### main.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:project/13_BottomNavigationBar/page_a.dart';
import 'package:project/13_BottomNavigationBar/page_b.dart';
import 'package:project/13_BottomNavigationBar/page_c.dart';

void main() {
  const app = MaterialApp(home: Root());
  const scope = ProviderScope(child: app);
  runApp(scope);
}

// 現在選択中のタブのインデックスを管理する
final indexProvider = StateProvider((ref) {
  return 0; // 初期値：0番目（画面A）
});

class Root extends ConsumerWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(indexProvider);

    const items = [
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'アイテム人',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'アイテム家',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'アイテム設定',
      ),
    ];

    final bar = BottomNavigationBar(
      items: items,
      backgroundColor: Colors.red,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      currentIndex: index,
      onTap: (index) {
        ref.read(indexProvider.notifier).state = index;
      },
    );

    final pages = [
      PageA(), // index: 0
      PageB(), // index: 1
      PageC(), // index: 2
    ];

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: bar,
    );
  }
}
```

### page_a.dart

```dart
import 'package:flutter/material.dart';

class PageA extends StatelessWidget {
  const PageA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
      body: const Center(
        child: Text(
          '画面 A',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
```

---

## 各パーツの解説

### BottomNavigationBarItem

```dart
BottomNavigationBarItem(
  icon: Icon(Icons.person), // アイコン
  label: 'アイテム人',       // ラベルテキスト
)
```

バーの各タブ1つ分。`icon` と `label` を設定する。

---

### BottomNavigationBar のプロパティ

| プロパティ | 説明 |
|-----------|------|
| `items` | タブのリスト（2〜5個） |
| `backgroundColor` | バーの背景色 |
| `selectedItemColor` | 選択中のアイコン・テキストの色 |
| `unselectedItemColor` | 未選択のアイコン・テキストの色 |
| `currentIndex` | 現在選択中のタブのインデックス |
| `onTap` | タップしたときに呼ばれる関数。引数にタップされたインデックスが渡される |

---

### Riverpod との連携

タップされたインデックスを `indexProvider` で管理し、`pages[index]` で対応する画面を切り替えている。

```dart
// タップしたらインデックスを更新
onTap: (index) {
  ref.read(indexProvider.notifier).state = index;
},

// インデックスに対応する画面を表示
body: pages[index],
```

---

## データの流れ

```
タブをタップ
    ↓
onTap(index) が呼ばれる
    ↓
indexProvider の値が更新される
    ↓
ref.watch(indexProvider) が再描画される
    ↓
pages[index] で対応する画面が表示される
```

---

## Widget の入れ子構造

```
ProviderScope
└── MaterialApp
    └── Root（ConsumerWidget）
        └── Scaffold
            ├── body: pages[index]
            │   ├── PageA（index: 0）
            │   ├── PageB（index: 1）
            │   └── PageC（index: 2）
            └── BottomNavigationBar
                ├── BottomNavigationBarItem（人）
                ├── BottomNavigationBarItem（家）
                └── BottomNavigationBarItem（設定）
```

---

## ポイントまとめ

- `BottomNavigationBar` は `Scaffold` の `bottomNavigationBar` に設定する
- タブは `BottomNavigationBarItem` のリストで定義する（2〜5個）
- 現在のタブは `currentIndex` で管理する
- Riverpod の `StateProvider` でインデックスを管理し、`pages[index]` で画面を切り替える
- `onTap` の引数にタップされたインデックスが渡される