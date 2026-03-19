# Riverpod の基礎

## Riverpod とは

アプリ全体でデータを共有・管理するための仕組み（状態管理）。

通常、Widget はそれぞれ独立しているので、別の Widget のデータを直接触ることができない。
Riverpod を使うと、**どの Widget からでも同じデータを読み書きできる**ようになる。

---

## 登場人物

| 名前 | 役割 |
|------|------|
| `ProviderScope` | アプリ全体をデータ管理できる状態にする |
| `StateProvider` | 管理するデータ（状態）を定義する |
| `ConsumerWidget` | Riverpod のデータを使える Widget |
| `ref.watch()` | データを監視する。データが変わると画面が自動更新される |
| `ref.read()` | データを一度だけ読む。ボタン操作など画面更新が不要なときに使う |
| `notifier.state` | データを書き換える |

---

## パッケージのインストール

```yaml
# pubspec.yaml
dependencies:
  flutter_riverpod: ^2.0.0
```

---

## コード全体

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

void main() {
  const app = MaterialApp(home: Example());
  // ProviderScope でアプリ全体を囲む（必須）
  const scope = ProviderScope(child: app);
  runApp(scope);
}

// プロバイダー（管理するデータを定義する）
final nicknameProvider = StateProvider<String>((ref) {
  return "ルビードッグ"; // 初期値
});

// ConsumerWidget（Riverpodのデータを使える画面）
class Example extends ConsumerWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // データを監視する（変わったら画面を自動更新）
    final nickname = ref.watch(nicknameProvider);

    return Scaffold(
      appBar: AppBar(title: Text(nickname)),  // ニックネーム1
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(nickname),  // ニックネーム2
            ElevatedButton(onPressed: () => tapA(ref), child: const Text('A')),
            ElevatedButton(onPressed: () => tapB(ref), child: const Text('B')),
            ElevatedButton(onPressed: () => tapC(ref), child: const Text('C')),
            Text(nickname),  // ニックネーム3
          ],
        ),
      ),
    );
  }

  // notifier.state でデータを書き換える
  void tapA(WidgetRef ref) {
    final notifier = ref.read(nicknameProvider.notifier);
    notifier.state = 'ルビーキャット';
  }

  void tapB(WidgetRef ref) {
    final notifier = ref.read(nicknameProvider.notifier);
    notifier.state = 'ルビーバード';
  }

  void tapC(WidgetRef ref) {
    final notifier = ref.read(nicknameProvider.notifier);
    notifier.state = 'ルビーフィッシュ';
  }
}
```

---

## 各パーツの解説

### ProviderScope

```dart
const scope = ProviderScope(child: app);
```

アプリ全体を `ProviderScope` で囲む。これをしないと Riverpod が動かない。**必ず必要。**

---

### StateProvider

```dart
final nicknameProvider = StateProvider<String>((ref) {
  return "ルビードッグ";
});
```

管理したいデータを定義する。
`<String>` の部分はデータの型。数字なら `<int>`、真偽値なら `<bool>` にする。

---

### ConsumerWidget

```dart
class Example extends ConsumerWidget {
  Widget build(BuildContext context, WidgetRef ref) {
```

通常の `StatelessWidget` の代わりに使う。
`build` メソッドに `WidgetRef ref` が追加されているのが特徴。

---

### ref.watch()

```dart
final nickname = ref.watch(nicknameProvider);
```

データを監視する。データが変わると**自動的に画面が再描画される**。
表示に使うデータはこちらを使う。

---

### ref.read() と notifier.state

```dart
void tapA(WidgetRef ref) {
  final notifier = ref.read(nicknameProvider.notifier);
  notifier.state = 'ルビーキャット';
}
```

`ref.read()` でデータの書き換え権限（notifier）を取得し、`notifier.state` に新しい値を代入するとデータが更新される。
ボタンを押したときなど、**画面更新のトリガーにならない場所**では `ref.read()` を使う。

---

## データの流れ

```
ボタンを押す
    ↓
ref.read(nicknameProvider.notifier).state = '新しい名前'
    ↓
nicknameProvider のデータが更新される
    ↓
ref.watch() で監視している箇所がすべて自動更新される
    ↓
AppBar・Text（3か所）が一度に書き換わる
```

---

## StatelessWidget との違い

| | StatelessWidget | ConsumerWidget |
|---|---|---|
| Riverpod のデータを使える | ❌ | ✅ |
| `ref` が使える | ❌ | ✅ |
| 画面の自動更新 | ❌ | ✅（ref.watch） |

---

## ポイントまとめ

- アプリ全体を `ProviderScope` で囲む（必須）
- データの定義は `StateProvider` で行う
- Riverpod を使う画面は `ConsumerWidget` にする
- **表示**するデータは `ref.watch()` で監視する
- **書き換える**ときは `ref.read().notifier.state` に代入する
- データが変わると `ref.watch()` している箇所がすべて自動で更新される