# Freezed の基礎

## Freezed とは

クラスに便利な機能を自動生成してくれるパッケージ。
手書きすると大変なコードをコマンド1つで自動で作ってくれる。

---

## Freezed が自動生成してくれるもの

| 機能 | 説明 |
|------|------|
| `copyWith()` | 一部だけ変えた新しいインスタンスを作る |
| `==`（イコール比較） | 中身が同じかどうか比較できる |
| `toString()` | デバッグ時に中身を文字列で確認できる |

---

## パッケージのインストール

```yaml
# pubspec.yaml
dependencies:
  freezed_annotation: ^2.0.0
  flutter_riverpod: ^2.0.0

dev_dependencies:
  freezed: ^2.0.0
  build_runner: ^2.0.0
```

---

## ファイル構成

```
lib/
└── 17_Freezed/
    ├── main.dart
    ├── fish.dart              ← 自分で書くファイル
    ├── fish.freezed.dart      ← 自動生成されるファイル（触らない）
    ├── abc_list.dart          ← 自分で書くファイル
    └── abc_list.freezed.dart  ← 自動生成されるファイル（触らない）
```

> `*.freezed.dart` は自動生成されるので**絶対に手動で編集しない**。

---

## コードの書き方

### fish.dart（自分で書く）

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fish.freezed.dart'; // 自動生成ファイルと紐づける

@freezed // Freezedを使うという宣言
abstract class Fish with _$Fish {
  const factory Fish({
    required String name,  // 名前（必須）
    required int size,     // 大きさ（必須）
    required int price,    // 値段（必須）
  }) = _Fish;
}
```

### abc_list.dart（自分で書く）

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
part 'abc_list.freezed.dart';

@freezed
abstract class AbcList with _$AbcList {
  factory AbcList(List<String> values) = _AbcList;
}
```

---

## コード生成コマンド

```bash
dart run build_runner build
```

このコマンドを実行すると `*.freezed.dart` ファイルが自動生成される。
クラスの中身を変えたら再度実行する。

---

## main.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:project/17_Freezed/abc_list.dart';
import 'package:project/17_Freezed/fish.dart';

void main() {
  const app = MaterialApp(home: Home());
  const scope = ProviderScope(child: app);
  runApp(scope);
}

// 魚データの状態管理
final fishProvider = StateProvider((ref) {
  return const Fish(
    name: 'マグロ',
    size: 200,
    price: 300,
  );
});

// ABCリストの状態管理
final abcListProvider = StateProvider((ref) {
  return AbcList(['A', 'B', 'C']);
});

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fish = ref.watch(fishProvider);
    final abcList = ref.watch(abcListProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('名前: ${fish.name}'),
            Text('大きさ: ${fish.size} cm'),
            Text('値段: ${fish.price} 万円'),
            Text('ABCリスト: $abcList'),
            ElevatedButton(
              onPressed: () => onPressed(ref),
              child: const Text('変更する'),
            ),
          ],
        ),
      ),
    );
  }

  void onPressed(WidgetRef ref) {
    // 今の魚データを取得
    final fish = ref.read(fishProvider);

    // copyWith で値段だけ変えた新しい魚を作る
    final newFish = fish.copyWith(price: 500);

    // 状態を更新
    ref.read(fishProvider.notifier).state = newFish;

    // --- --- ---

    // 今のABCリストを取得
    final abcList = ref.read(abcListProvider);

    // copyWith でDを追加した新しいリストを作る
    final newAbcList = abcList.copyWith(
      values: abcList.values + ['D'],
    );

    ref.read(abcListProvider.notifier).state = newAbcList;
  }
}
```

---

## copyWith の使い方

Freezed の一番重要な機能。
**指定したプロパティだけ変えた新しいインスタンスを作る。**

```dart
final fish = Fish(name: 'マグロ', size: 200, price: 300);

// price だけ 500 に変えた新しい Fish を作る
// name と size はそのままコピーされる
final newFish = fish.copyWith(price: 500);

// newFish → Fish(name: 'マグロ', size: 200, price: 500)
```

---

## なぜ直接変更しないのか

Freezed のクラスは**イミュータブル（変更不可）**。
プロパティを直接書き換えることができないので、`copyWith` で新しいインスタンスを作って差し替える。

```dart
// ❌ 直接変更はできない
fish.price = 500;

// ✅ copyWith で新しいインスタンスを作る
final newFish = fish.copyWith(price: 500);
ref.read(fishProvider.notifier).state = newFish;
```

---

## 通常のクラスとFreezedクラスの違い

```dart
// 通常のクラス → 自分でコードを書く必要がある
class Fish {
  final String name;
  final int size;
  final int price;

  Fish({required this.name, required this.size, required this.price});

  Fish copyWith({String? name, int? size, int? price}) {
    return Fish(
      name: name ?? this.name,
      size: size ?? this.size,
      price: price ?? this.price,
    );
  }

  @override
  bool operator ==(Object other) => ...; // 長い

  @override
  String toString() => 'Fish(name: $name, size: $size, price: $price)';
}

// Freezed → @freezed をつけてコマンドを叩くだけで上記が全部自動生成される
@freezed
abstract class Fish with _$Fish {
  const factory Fish({
    required String name,
    required int size,
    required int price,
  }) = _Fish;
}
```

---

## ポイントまとめ

- `@freezed` をつけてコマンドを実行すると `copyWith` などが自動生成される
- `*.freezed.dart` は自動生成ファイルなので絶対に手動編集しない
- `copyWith` で指定したプロパティだけ変えた新しいインスタンスを作れる
- Freezed のクラスはイミュータブルなので直接プロパティを変更できない
- クラスの中身を変えたら `dart run build_runner build` を再実行する