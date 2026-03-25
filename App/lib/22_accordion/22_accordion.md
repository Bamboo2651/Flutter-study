# Flutter アコーディオン実装の解説

このプログラムは、**「共通パーツ（部品）」**と**「それを使う画面」**の2つのファイルで構成されています。

---

## 1. accordion.dart（共通パーツ側）
このファイルでは、開閉可能なパネル（アコーディオン）の「見た目」と「動き」を定義しています。

### 主なポイント
* **`ExpansionTile` ウィジェット:**
    タップすると中身（`children`）が開いたり閉じたりする、Flutter標準のウィジェットです。
* **プロパティの共通化:**
    色（`headColor`, `bodyColor`）、タイトル（`title`）、画像パス（`imageName`）を外部から受け取れるように設計されています。
* **デザインの設定:**
    `collapsedTextColor` や `iconColor` を白（`Colors.white`）に固定することで、背景色が変わっても文字が見やすいように調整されています。

```dart
// 抜粋：中身（画像）を表示する部分
children: [
  Container(
    color: bodyColor, // 背景色を指定
    width: double.infinity,
    height: 100,
    alignment: Alignment.center,
    child: Image.asset(imageName), // assets内の画像を表示
  ),
],
```

---

## 2. main.dart（画面側）
このファイルでは、`accordion.dart` で作った部品を複数並べて、実際の画面（UI）を構築しています。

### 主なポイント
* **部品の再利用:**
    `Accordion(...)` を呼び出す際に、それぞれ「バナナ」「リンゴ」といった異なるデータ（色や画像パス）を渡すだけで、同じ見た目のパネルを量産しています。
* **`SingleChildScrollView`:**
    アコーディオンをたくさん並べて画面からはみ出しても、上下にスクロールできるようにしています。
* **`Column`:**
    複数のアコーディオンを上から下へ順番に並べています。

```dart
// 抜粋：部品を並べている部分
final column = Column(
  children: [
    Accordion(
      title: 'バナナ',
      headColor: Colors.orange,
      bodyColor: Colors.orange.shade200,
      imageName: 'assets/images/banana.png',
    ),
    // ...以下、リンゴ、メロン、ブドウと続く
  ],
);
```

---

## 全体の構造イメージ

1.  **`main.dart`** が実行される
2.  `HomePage` の `Scaffold`（土台）が表示される
3.  `SingleChildScrollView` の中で `Column` が展開される
4.  `Column` の中で、**`Accordion` 部品が4回呼び出される**
5.  それぞれの `Accordion` が、受け取ったデータをもとに `ExpansionTile` を描画する

---

### 💡 実行時の注意点
このコードを動かすには、`pubspec.yaml` の `assets` セクションに以下の画像ファイルが登録されている必要があります。
* `assets/images/banana.png`
* `assets/images/apple.png`
* `assets/images/melon.png`
* `assets/images/grape.png`