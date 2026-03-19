# go_router の基礎

## go_router とは

画面遷移を管理するためのパッケージ。
パス（`/a`, `/b` など）と画面を紐づけて、URLのように画面を管理できる。

---

## パッケージのインストール

```yaml
# pubspec.yaml
dependencies:
  go_router: ^13.0.0
```

---

## ファイル構成

```
lib/
└── 11_go_router/
    ├── main.dart    ← ルーターの定義・アプリの起点
    ├── page_a.dart  ← 画面A
    ├── page_b.dart  ← 画面B
    └── page_c.dart  ← 画面C
```

---

## コード全体

### main.dart

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/11_go_router/page_a.dart';
import 'package:project/11_go_router/page_b.dart';
import 'package:project/11_go_router/page_c.dart';

void main() {
  final app = App();
  runApp(app);
}

class App extends StatelessWidget {
  App({super.key});

  final router = GoRouter(
    initialLocation: '/a',   // アプリ起動時に最初に表示する画面
    routes: [
      GoRoute(
        path: '/a',
        builder: (context, state) => const PageA(),
      ),
      GoRoute(
        path: '/b',
        builder: (context, state) => const PageB(),
      ),
      GoRoute(
        path: '/c',
        builder: (context, state) => const PageC(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
```

### page_a.dart

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageA extends StatelessWidget {
  const PageA({super.key});

  void push(BuildContext context) {
    context.push('/b'); // 画面Bへ進む
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.red,
      title: const Text('画面 A'),
    );

    final pushButton = ElevatedButton(
      onPressed: () => push(context),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      child: const Text('進む >'),
    );

    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [pushButton],
        ),
      ),
    );
  }
}
```

---

## 各パーツの解説

### GoRouter

```dart
final router = GoRouter(
  initialLocation: '/a',
  routes: [...],
);
```

| プロパティ | 説明 |
|-----------|------|
| `initialLocation` | アプリ起動時に最初に表示するパス |
| `routes` | パスと画面の組み合わせのリスト |

---

### GoRoute

```dart
GoRoute(
  path: '/a',
  builder: (context, state) => const PageA(),
)
```

| プロパティ | 説明 |
|-----------|------|
| `path` | URLのようなパス文字列 |
| `builder` | そのパスに対応する画面Widget を返す関数 |

---

### MaterialApp.router

```dart
return MaterialApp.router(
  routeInformationProvider: router.routeInformationProvider,
  routeInformationParser: router.routeInformationParser,
  routerDelegate: router.routerDelegate,
);
```

通常の `MaterialApp` の代わりに使う。
go_router を使う場合はこちらが必要。

---

### 画面遷移の方法

```dart
// 進む（スタックに積む）
context.push('/b');

// 置き換える（戻れなくなる）
context.go('/b');
```

| メソッド | 説明 |
|---------|------|
| `context.push('/b')` | 画面Bに進む。戻るボタンで画面Aに戻れる |
| `context.go('/b')` | 画面Bに置き換える。戻るボタンで戻れない |
| `context.pop()` | 前の画面に戻る |

---

## 画面遷移のイメージ

```
push を使った場合（スタック）
画面A → push('/b') → 画面B → push('/c') → 画面C
                              ← pop()      ← pop()

go を使った場合（置き換え）
画面A → go('/b') → 画面B（Aには戻れない）
```

---

## ポイントまとめ

- go_router はパスと画面を紐づけて画面遷移を管理する
- アプリ全体を `MaterialApp.router` で包む
- `initialLocation` で起動時の画面を指定する
- 戻れる遷移は `context.push()`、戻れない遷移は `context.go()`
- 前の画面に戻るときは `context.pop()`