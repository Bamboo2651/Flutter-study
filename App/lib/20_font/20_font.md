# Google Fonts の基礎

## Google Fonts とは

Googleが提供している無料のフォントをアプリで使えるようにするパッケージ。
日本語フォントも使える。

---

## パッケージのインストール

```yaml
# pubspec.yaml
dependencies:
  google_fonts: ^6.0.0
```

---

## ファイル構成

```
lib/
└── main.dart
google_fonts/
└── OFL.txt  ← フォントのライセンスファイル（必須）
```

---

## コード全体

```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  // OFL を守るためにライセンスを登録する（必須）
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

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
    // Google Fonts を使ったテキスト
    final text = Text(
      'バナナ美味しい',
      style: GoogleFonts.hachiMaruPop(
        fontSize: 30,
        fontWeight: FontWeight.w600,
      ),
    );

    // ライセンスページを開くボタン
    void onPressed() {
      showLicensePage(context: context);
    }

    final button = ElevatedButton(
      onPressed: onPressed,
      child: const Text('ボタン'),
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [text, button],
        ),
      ),
    );
  }
}
```

---

## 各パーツの解説

### GoogleFonts の使い方

```dart
Text(
  'バナナ美味しい',
  style: GoogleFonts.hachiMaruPop(
    fontSize: 30,
    fontWeight: FontWeight.w600,
  ),
)
```

`GoogleFonts.フォント名()` で `TextStyle` を生成して `style` に渡すだけでOK。

**フォント名の例：**

| フォント名 | 説明 |
|-----------|------|
| `hachiMaruPop` | はちまるポップ（丸みのある日本語フォント） |
| `notoSansJP` | Noto Sans JP（読みやすい日本語フォント） |
| `rocknRollOne` | ロックンロール（ポップな日本語フォント） |

> 使えるフォントは [fonts.google.com](https://fonts.google.com) で確認できる。

---

### LicenseRegistry（ライセンス登録）

```dart
LicenseRegistry.addLicense(() async* {
  final license = await rootBundle.loadString('google_fonts/OFL.txt');
  yield LicenseEntryWithLineBreaks(['google_fonts'], license);
});
```

Google Fonts は **OFL（Open Font License）** というライセンスに従って使う必要がある。
このコードでアプリにライセンス情報を登録している。

> `OFL.txt` がないとライセンス違反になるので必ず用意する。

---

### showLicensePage()

```dart
showLicensePage(context: context);
```

アプリに登録されているすべてのライセンスを一覧表示するページを開く。
`LicenseRegistry.addLicense()` で登録したライセンスもここに表示される。

---

## Widget の入れ子構造

```
MaterialApp
└── HomePage
    └── Scaffold
        └── Center
            └── Column（spaceEvenly）
                ├── Text（GoogleFonts.hachiMaruPop）
                └── ElevatedButton（showLicensePage）
```

---

## ポイントまとめ

- `google_fonts` パッケージで簡単にフォントを変えられる
- `GoogleFonts.フォント名()` で `TextStyle` を生成して `style` に渡す
- OFLライセンスを守るために `LicenseRegistry.addLicense()` と `OFL.txt` が必要
- `showLicensePage()` でアプリのライセンス一覧ページを表示できる
- 使えるフォントは [fonts.google.com](https://fonts.google.com) で探せる