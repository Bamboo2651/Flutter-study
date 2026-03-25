# Firebase Analytics の基礎

## Firebase Analytics とは

アプリ内でのユーザー行動を計測・分析するツール。
「どの画面がよく見られているか」「どのボタンがよく押されているか」などを数値で把握できる。

**感覚ではなくデータに基づいてアプリを改善できる。**

---

## 取得できる情報

| 情報 | 例 |
|------|----|
| 閲覧した画面 | ホーム画面を1000人が見た |
| ボタン操作 | ログインボタンが500回押された |
| 機能の利用頻度 | 検索機能は週100回使われている |
| ユーザーの行動傾向 | 登録後3日以内に離脱するユーザーが多い |

---

## 前提条件

以下がすでに完了していること。

- Firebase プロジェクトが作成済み
- Flutter アプリが Firebase と連携済み
- `firebase_core` の初期設定が完了済み

---

## パッケージのインストール

```yaml
# pubspec.yaml
dependencies:
  firebase_analytics: ^10.0.0
```

---

## 基本的な使い方

### インスタンスの取得

```dart
final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
```

---

### 画面遷移の計測

Flutterでは画面遷移が**自動では計測されない**ので、各画面で明示的に書く必要がある。

```dart
await analytics.setCurrentScreen(
  screenName: 'HomePage',
  screenClassOverride: 'HomePage',
);
```

> これを各画面の `initState` や `build` の中に書くことで、どの画面が見られているかを把握できる。

---

### カスタムイベントの送信

ボタンタップなど特定の操作をイベントとして送信できる。

```dart
await analytics.logEvent(
  name: 'button_click',       // イベント名
  parameters: {
    'button_name': 'login_button', // 追加情報
  },
);
```

**イベント設計のポイント：**

| ポイント | 説明 |
|---------|------|
| 目的を明確にする | 何を分析したいかを決めてからイベントを作る |
| イベントを増やしすぎない | 不要なイベントは分析が複雑になる |
| 名前を統一する | `button_click` / `btn_tap` のようにバラバラにしない |

---

## Firebase コンソールで確認

送信したイベントは Firebase コンソールで確認できる。

| 確認方法 | 反映時間 |
|---------|---------|
| リアルタイムビュー | ほぼ即時 |
| 通常の分析画面 | 数時間〜1日かかることがある |

---

## 他の Firebase 機能との連携

Analytics 単体でも使えるが、他の機能と組み合わせるとより強力になる。

| 機能 | 用途 |
|------|------|
| Crashlytics | アプリのクラッシュを分析する |
| Remote Config | アプリの設定をサーバーから動的に変更する |
| A/B テスト | 2種類のUIをユーザーに出し分けて効果を比較する |

---

## ポイントまとめ

- Firebase Analytics でユーザーの行動をデータで把握できる
- 画面遷移は自動計測されないので各画面で `setCurrentScreen()` を呼ぶ
- `logEvent()` でボタン操作などのカスタムイベントを送信できる
- イベントは目的を明確にして、名前を統一して設計する
- Crashlytics や Remote Config と組み合わせるとより高度な改善ができる