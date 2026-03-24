# JSON の基礎

## JSON とは

データをやり取りするための形式。
APIから取得したデータやファイルに保存したデータはJSON形式であることが多い。

```json
{
  "name": "トマト",
  "color": "赤",
  "season": "夏"
}
```

---

## 今回やること

ローカルのJSONファイルを読み込んで、Dartのクラスに変換する。

```
stub/level1.json（JSONファイル）
        ↓
jsonDecode()（文字列 → Map）
        ↓
Vegetable.fromJson()（Map → Dartクラス）
        ↓
debugPrint() で中身を確認
```

---

## パッケージのインストール

```yaml
# pubspec.yaml
dependencies:
  freezed_annotation: ^2.0.0
  json_annotation: ^4.0.0

dev_dependencies:
  freezed: ^2.0.0
  build_runner: ^2.0.0
  json_serializable: ^6.0.0
```

---

## ファイル構成

```
lib/
└── 19_json/
    ├── main.dart
    ├── vegetable.dart           ← 自分で書くファイル
    ├── vegetable.freezed.dart   ← 自動生成（触らない）
    └── vegetable.g.dart         ← 自動生成（触らない）
stub/
└── level1.json                  ← 読み込むJSONファイル
```

> `vegetable.freezed.dart` と `vegetable.g.dart` は自動生成なので触らない。

---

## コード全体

### vegetable.dart

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
part 'vegetable.freezed.dart';
part 'vegetable.g.dart'; // JSON変換コードが生成される

@freezed
class Vegetable with _$Vegetable {
  const factory Vegetable({
    required String name,   // 名前
    required String color,  // 色
    required String season, // 旬の季節
  }) = _Vegetable;

  // JSONからVegetableに変換するコンストラクタ
  factory Vegetable.fromJson(Map<String, dynamic> json) =>
      _$VegetableFromJson(json);
}
```

### main.dart

```dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/19_json/vegetable.dart';

void main() {
  test1();
}

void test1() async {
  WidgetsFlutterBinding.ensureInitialized();

  // JSONファイルを文字列として読み込む
  final json = await rootBundle.loadString('stub/level1.json');

  // 文字列をMapに変換
  final map = jsonDecode(json);

  // MapをVegetableクラスに変換
  final data = Vegetable.fromJson(map);

  debugPrint('データの中身は $data');
}
```

---

## 各パーツの解説

### part ディレクティブ

```dart
part 'vegetable.freezed.dart'; // Freezed用
part 'vegetable.g.dart';       // JSON変換用
```

自動生成ファイルをこのファイルの一部として紐づける宣言。
`vegetable.g.dart` には `fromJson` / `toJson` の実装が自動生成される。

---

### fromJson

```dart
factory Vegetable.fromJson(Map<String, dynamic> json) =>
    _$VegetableFromJson(json);
```

`Map<String, dynamic>` （JSONをDartで扱う型）を `Vegetable` クラスに変換する。
`_$VegetableFromJson` は `vegetable.g.dart` に自動生成される。

---

### WidgetsFlutterBinding.ensureInitialized()

```dart
WidgetsFlutterBinding.ensureInitialized();
```

`main()` 以外の場所で非同期処理（`async`）を使う前に必要な初期化処理。
これがないと `rootBundle` が使えない。

---

### rootBundle.loadString()

```dart
final json = await rootBundle.loadString('stub/level1.json');
```

アプリに含まれているファイルを文字列として読み込む。
`pubspec.yaml` に登録が必要。

```yaml
flutter:
  assets:
    - stub/
```

---

### jsonDecode()

```dart
final map = jsonDecode(json); // String → Map<String, dynamic>
```

JSON文字列を Dart の `Map` に変換する。

---

### 変換の流れ

```
level1.json（ファイル）
  ↓ rootBundle.loadString()
String（文字列）
  ↓ jsonDecode()
Map<String, dynamic>（{"name": "トマト", ...}）
  ↓ Vegetable.fromJson()
Vegetable（Dartクラス）
  ↓ debugPrint()
"データの中身は Vegetable(name: トマト, color: 赤, season: 夏)"
```

---

## コード生成コマンド

```bash
dart run build_runner build
```

`vegetable.dart` を変更したら再実行する。

---

## 17_Freezed との違い

| | 17_Freezed | 19_JSON |
|---|---|---|
| 自動生成ファイル | `*.freezed.dart` | `*.freezed.dart` + `*.g.dart` |
| 追加する機能 | `copyWith` など | `fromJson` / `toJson` |
| 追加するアノテーション | `@freezed` のみ | `@freezed` + `fromJson` |

---

## ポイントまとめ

- JSONを扱うには `freezed` + `json_serializable` の2つが必要
- `part 'vegetable.g.dart'` を追加するとJSON変換コードが自動生成される
- `fromJson()` で `Map` → Dartクラスに変換できる
- `rootBundle.loadString()` でローカルのファイルを読み込める
- `WidgetsFlutterBinding.ensureInitialized()` は非同期処理の前に必要