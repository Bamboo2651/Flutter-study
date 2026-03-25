# Flavor（フレーバー）の基礎

## Flavor とは

アプリを「開発用・試験用・製品用」の3種類に分けて管理する仕組み。

| 略称 | 正式名 | 用途 |
|------|--------|------|
| `dev` | Development（開発） | 開発中に使う。自由に試せる |
| `stg` | Staging（試験） | 本番に近い環境でテストする |
| `prd` | Production（製品） | 実際にユーザーが使う本番環境 |

---

## なぜ分けるのか

**安心して開発ができるから。**

本番環境（prd）のデータを壊さずに、開発環境（dev）で自由に試せる。
例えば「開発中にDBのデータを全部消してしまった」という事故を防げる。

---

## ファイル構成

```
lib/
└── main.dart         ← libの直下に置く（必須）
scripts/
└── flavors/
    ├── dev.json      ← 開発用の設定
    ├── stg.json      ← 試験用の設定
    └── prd.json      ← 製品用の設定
```

### json ファイルの例

```json
{
  "flavor": "dev"
}
```

---

## コード全体

```dart
import 'package:flutter/material.dart';

void main() {
  // フレーバーを取得する
  const flavor = String.fromEnvironment('flavor');

  if (flavor == 'dev') {
    // dev のときだけ実行される
  }

  if (flavor == 'stg') {
    // stg のときだけ実行される
    debugPrint('バナナだぁぁぁ');
  }

  if (flavor == 'prd') {
    // prd のときだけ実行される
  }

  const app = MyApp();
  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('バナナ')),
    );
  }
}
```

---

## 各パーツの解説

### String.fromEnvironment()

```dart
const flavor = String.fromEnvironment('flavor');
```

実行時に渡された環境変数を取得する。
`--dart-define-from-file` で渡した JSON の値がここに入る。

---

### if 文でフレーバーを分岐

```dart
if (flavor == 'dev') {
  // dev のときだけ実行
}
if (flavor == 'stg') {
  // stg のときだけ実行
}
if (flavor == 'prd') {
  // prd のときだけ実行
}
```

フレーバーによって処理を切り替えられる。
例えばdev のときだけデバッグ用のログを出す、prd のときだけ本番APIに繋ぐ、といった使い方ができる。

---

## 実行コマンド

```bash
# dev で実行
flutter run -d chrome --dart-define-from-file=scripts/flavors/dev.json

# stg で実行
flutter run -d chrome --dart-define-from-file=scripts/flavors/stg.json

# prd で実行
flutter run -d chrome --dart-define-from-file=scripts/flavors/prd.json
```

> `main.dart` は必ず `lib/` 直下に置く。

---

## 毎回コマンドを打つのが面倒な場合

VSCode の左側の実行ボタン（▶）から `dev` / `stg` / `prd` を選んで実行できるように設定できる。

`.vscode/launch.json` に以下を追加する。

```json
{
  "configurations": [
    {
      "name": "dev",
      "request": "launch",
      "type": "dart",
      "args": ["--dart-define-from-file=scripts/flavors/dev.json"]
    },
    {
      "name": "stg",
      "request": "launch",
      "type": "dart",
      "args": ["--dart-define-from-file=scripts/flavors/stg.json"]
    },
    {
      "name": "prd",
      "request": "launch",
      "type": "dart",
      "args": ["--dart-define-from-file=scripts/flavors/prd.json"]
    }
  ]
}
```

---

## 停止方法

```bash
Ctrl + C
```

---

## ポイントまとめ

- Flavor で `dev` / `stg` / `prd` の3環境に分けて管理する
- 分けることで本番データを壊さず安心して開発できる
- `String.fromEnvironment()` で現在のフレーバーを取得する
- `--dart-define-from-file` でJSONファイルから環境変数を渡す
- `main.dart` は `lib/` 直下に置く必要がある
- VSCode の `launch.json` を設定すると毎回コマンドを打たなくてよくなる