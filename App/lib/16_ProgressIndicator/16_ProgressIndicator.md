# ProgressIndicator の基礎

## 今回学ぶ Widget

| Widget | 説明 |
|--------|------|
| `CircularPercentIndicator` | 丸型のプログレスバー |
| `LinearPercentIndicator` | 棒型のプログレスバー |

> `percent_indicator` という外部パッケージを使う。

---

## パッケージのインストール

```yaml
# pubspec.yaml
dependencies:
  percent_indicator: ^4.0.0
```

---

## コード全体

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() {
  const app = MaterialApp(home: Home());
  const scope = ProviderScope(child: app);
  runApp(scope);
}

// パーセントの状態管理（0.0〜1.0）
final percentProvider = StateProvider((ref) {
  return 0.00;
});

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final percent = ref.watch(percentProvider);

    // 丸型インジケーター
    final circular = CircularPercentIndicator(
      percent: percent,
      backgroundColor: Colors.yellow,
      progressColor: Colors.green,
      animation: true,
      animationDuration: 200,
      animateFromLastPercent: true,
      radius: 60.0,
      lineWidth: 20.0,
      center: Text('${percent * 100}%'),
    );

    // 棒型インジケーター
    final linear = LinearPercentIndicator(
      percent: percent,
      backgroundColor: Colors.yellow,
      progressColor: Colors.green,
      animation: true,
      animationDuration: 200,
      animateFromLastPercent: true,
      alignment: MainAxisAlignment.center,
      lineHeight: 20,
      width: 300,
      center: Text('${percent * 100}%'),
    );

    // スタートボタン
    final button = ElevatedButton(
      onPressed: () => onPressed(ref),
      child: const Text('スタート'),
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [circular, linear, button],
        ),
      ),
    );
  }

  // ボタンを押したときの処理
  void onPressed(WidgetRef ref) async {
    await Future.delayed(const Duration(seconds: 1));
    ref.read(percentProvider.notifier).state = 0.20;
    await Future.delayed(const Duration(seconds: 1));
    ref.read(percentProvider.notifier).state = 0.40;
    await Future.delayed(const Duration(seconds: 1));
    ref.read(percentProvider.notifier).state = 0.60;
    await Future.delayed(const Duration(seconds: 1));
    ref.read(percentProvider.notifier).state = 0.80;
    await Future.delayed(const Duration(seconds: 1));
    ref.read(percentProvider.notifier).state = 1.00;
  }
}
```

---

## 各パーツの解説

### CircularPercentIndicator（丸型）

```dart
CircularPercentIndicator(
  percent: percent,              // 現在の進捗（0.0〜1.0）
  backgroundColor: Colors.yellow, // 未進捗部分の色
  progressColor: Colors.green,    // 進捗部分の色
  animation: true,                // アニメーションをオンにする
  animationDuration: 200,         // アニメーションの時間（ミリ秒）
  animateFromLastPercent: true,   // 前の値からアニメーションする
  radius: 60.0,                   // 円の半径
  lineWidth: 20.0,                // 線の太さ
  center: Text('${percent * 100}%'), // 中央に表示するWidget
)
```

---

### LinearPercentIndicator（棒型）

```dart
LinearPercentIndicator(
  percent: percent,
  backgroundColor: Colors.yellow,
  progressColor: Colors.green,
  animation: true,
  animationDuration: 200,
  animateFromLastPercent: true,
  alignment: MainAxisAlignment.center, // バーの位置
  lineHeight: 20,                      // バーの太さ
  width: 300,                          // バーの横幅
  center: Text('${percent * 100}%'),   // バーの中央に表示するWidget
)
```

---

### 共通プロパティ

| プロパティ | 説明 |
|-----------|------|
| `percent` | 進捗の値。`0.0`（0%）〜 `1.0`（100%） |
| `backgroundColor` | 未進捗部分の色 |
| `progressColor` | 進捗部分の色 |
| `animation` | アニメーションのオン/オフ |
| `animationDuration` | アニメーションの長さ（ミリ秒） |
| `animateFromLastPercent` | `true` にすると前の値から滑らかにアニメーションする |
| `center` | インジケーターの中央に表示するWidget |

---

### async / await と Future.delayed

```dart
void onPressed(WidgetRef ref) async {
  await Future.delayed(const Duration(seconds: 1)); // 1秒待つ
  ref.read(percentProvider.notifier).state = 0.20;  // 20%に更新
  await Future.delayed(const Duration(seconds: 1)); // 1秒待つ
  ref.read(percentProvider.notifier).state = 0.40;  // 40%に更新
  // ...
}
```

| キーワード | 説明 |
|-----------|------|
| `async` | この関数は非同期処理を含むという宣言 |
| `await` | 処理が終わるまで次の行に進まず待つ |
| `Future.delayed()` | 指定した時間だけ処理を止める |
| `Duration(seconds: 1)` | 1秒を表す |

> `async` / `await` がないと1秒待たずに一瞬で100%になってしまう。

---

## 処理の流れ

```
ボタンを押す
    ↓
1秒待つ → 20%に更新 → インジケーターがアニメーション
    ↓
1秒待つ → 40%に更新 → インジケーターがアニメーション
    ↓
1秒待つ → 60%に更新
    ↓
1秒待つ → 80%に更新
    ↓
1秒待つ → 100%に更新
```

---

## Widget の入れ子構造

```
ProviderScope
└── MaterialApp
    └── Home（ConsumerWidget）
        └── Scaffold
            └── Center
                └── Column（spaceEvenly）
                    ├── CircularPercentIndicator
                    ├── LinearPercentIndicator
                    └── ElevatedButton
```

---

## ポイントまとめ

- `percent_indicator` パッケージを使うと丸型・棒型のプログレスバーが簡単に作れる
- `percent` は `0.0〜1.0` で指定する（%ではなく小数）
- `animateFromLastPercent: true` で滑らかなアニメーションになる
- `async` / `await` で一定時間ごとに進捗を更新できる
- `Future.delayed()` で指定時間だけ処理を止められる