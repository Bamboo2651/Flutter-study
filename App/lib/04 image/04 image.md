# 画像の表示方法

## 1. 事前準備

### フォルダを作る

プロジェクト直下に以下のフォルダを作成する。

```
assets/
└── images/
```

### pubspec.yaml に追記する

```yaml
flutter:
  assets:
    - assets/images/
```

> ⚠️ インデントがずれるとエラーになるので注意

---

## 2. 画像を表示する4つの方法

| メソッド | どこから表示するか |
|---------|-----------------|
| `Image.asset()` | アプリ内のローカルファイル |
| `Image.network()` | インターネット上のURL |
| `Image.memory()` | メモリ上のバイトデータ |
| `Image.file()` | デバイスのストレージ上のファイル |

---

### 1. Image.asset()

アプリに含めたローカルの画像を表示する。

```dart
final img = Image.asset(
  'assets/images/apple.png',
);
```

> `pubspec.yaml` に登録したフォルダ内の画像を指定する。

---

### 2. Image.network()

インターネット上の画像URLから表示する。

```dart
final img = Image.network(
  'https://example.com/image.jpg',
);
```

> ネット接続が必要。読み込みに時間がかかる場合がある。

---

### 3. Image.memory()

メモリ上のバイトデータ（`Uint8List`）から画像を表示する。

```dart
final img = Image.memory(
  byteData, // Uint8List型のデータ
);
```

> カメラで撮影した画像やAPIから取得したバイナリデータをそのまま表示したいときに使う。ファイルに保存せず直接表示できる。

---

### 4. Image.file()

スマホのストレージ（ギャラリーなど）に保存されているファイルを表示する。

```dart
import 'dart:io';

final img = Image.file(
  File('/storage/emulated/0/Pictures/photo.jpg'),
);
```

> ユーザーがギャラリーから選んだ画像を表示するときなどに使う。`dart:io` のインポートが必要。

---

## まとめ・使い分け

| 場面 | 使うメソッド |
|------|------------|
| アプリに最初から含める画像 | `Image.asset()` |
| WebサービスのAPIから画像を取得 | `Image.network()` |
| カメラ撮影・バイナリデータ | `Image.memory()` |
| ユーザーのギャラリーから選択 | `Image.file()` |