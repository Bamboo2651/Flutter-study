# Switch / Slider の基礎

## 今回学ぶ Widget

| Widget | 説明 |
|--------|------|
| `Switch` | オン/オフを切り替えるトグルスイッチ |
| `Slider` | 1つのつまみで値を調整するスライダー |
| `RangeSlider` | 2つのつまみで範囲を指定するスライダー |

---

## コード全体

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

void main(List<String> args) {
  const app = MaterialApp(home: Home());
  const scope = ProviderScope(child: app);
  runApp(scope);
}

// スイッチのオン/オフ状態
final isOnProvider = StateProvider((ref) {
  return true; // 最初はオンの状態
});

// スライダーの値（0.0〜1.0）
final valuProvider = StateProvider((ref) {
  return 0.0;
});

// レンジスライダーの範囲
final rangeProvider = StateProvider((ref) {
  return const RangeValues(0.0, 1.0);
});

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // スイッチ
    final isOn = ref.watch(isOnProvider);
    final toggleSwitch = Switch(
      value: isOn,
      onChanged: (isOn) {
        ref.read(isOnProvider.notifier).state = isOn;
      },
      activeThumbColor: Colors.blue,    // オン時のつまみの色
      activeTrackColor: Colors.green,   // オン時のトラックの色
      inactiveThumbColor: Colors.black, // オフ時のつまみの色
      inactiveTrackColor: Colors.grey,  // オフ時のトラックの色
    );

    // スライダー
    final value = ref.watch(valuProvider);
    final slider = Slider(
      value: value,
      onChanged: (value) {
        ref.read(valuProvider.notifier).state = value;
      },
      thumbColor: Colors.blue,       // つまみの色
      activeColor: Colors.green,     // つまみより左側の色
      inactiveColor: Colors.black12, // つまみより右側の色
    );

    // レンジスライダー
    final range = ref.watch(rangeProvider);
    final rangeSlider = RangeSlider(
      values: range,
      onChanged: (value) {
        ref.read(rangeProvider.notifier).state = value;
      },
      activeColor: Colors.green,     // 範囲内の色
      inactiveColor: Colors.black12, // 範囲外の色
    );

    // スライダーの値に連動して幅が変わるコンテナ
    final con = Container(
      width: value * 400, // スライダーの値（0.0〜1.0）× 400
      height: 20,
      color: Colors.red,
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [toggleSwitch, slider, rangeSlider, con],
        ),
      ),
    );
  }
}
```

---

## 各 Widget の解説

### Switch（トグルスイッチ）

```dart
Switch(
  value: isOn,              // 現在のオン/オフ状態（bool）
  onChanged: (isOn) { ... } // 切り替えたときの処理
)
```

| プロパティ | 説明 |
|-----------|------|
| `value` | 現在の状態。`true` でオン、`false` でオフ |
| `onChanged` | 切り替えたときに呼ばれる。新しい状態が渡される |
| `activeThumbColor` | オン時のつまみの色 |
| `activeTrackColor` | オン時のトラック（背景）の色 |
| `inactiveThumbColor` | オフ時のつまみの色 |
| `inactiveTrackColor` | オフ時のトラック（背景）の色 |

---

### Slider

```dart
Slider(
  value: value,              // 現在の値（double）
  onChanged: (value) { ... } // 動かしたときの処理
)
```

| プロパティ | 説明 |
|-----------|------|
| `value` | 現在の値。デフォルトは `0.0〜1.0` |
| `min` / `max` | 最小値・最大値（省略すると 0.0〜1.0） |
| `onChanged` | つまみを動かしたときに呼ばれる |
| `thumbColor` | つまみの色 |
| `activeColor` | つまみより左側（選択済み）の色 |
| `inactiveColor` | つまみより右側（未選択）の色 |

---

### RangeSlider

```dart
RangeSlider(
  values: range,              // 現在の範囲（RangeValues）
  onChanged: (value) { ... }  // 動かしたときの処理
)
```

| プロパティ | 説明 |
|-----------|------|
| `values` | 現在の範囲。`RangeValues(開始値, 終了値)` で指定 |
| `min` / `max` | 最小値・最大値 |
| `onChanged` | つまみを動かしたときに呼ばれる |
| `activeColor` | 範囲内の色 |
| `inactiveColor` | 範囲外の色 |

---

### スライダーの値を Widget に連動させる

```dart
// スライダーの値（0.0〜1.0）× 400 = 0〜400px
final con = Container(
  width: value * 400,
  height: 20,
  color: Colors.red,
);
```

スライダーを動かすと `value` が更新され、`ref.watch()` が反応してコンテナの幅がリアルタイムで変わる。

---

## Provider の役割

| Provider | 管理するデータ | 型 |
|---------|--------------|-----|
| `isOnProvider` | スイッチのオン/オフ | `bool` |
| `valuProvider` | スライダーの値 | `double` |
| `rangeProvider` | レンジスライダーの範囲 | `RangeValues` |

---

## Widget の入れ子構造

```
ProviderScope
└── MaterialApp
    └── Home（ConsumerWidget）
        └── Scaffold
            └── Center
                └── Column（spaceEvenly）
                    ├── Switch
                    ├── Slider
                    ├── RangeSlider
                    └── Container（幅がスライダーに連動）
```

---

## ポイントまとめ

- `Switch` は `bool`、`Slider` は `double`、`RangeSlider` は `RangeValues` で値を管理する
- `value` に現在の値を渡し、`onChanged` で Provider を更新するだけで動く
- Riverpod と組み合わせることで値の変化をリアルタイムに他の Widget へ反映できる
- `Slider` のデフォルト範囲は `0.0〜1.0`。変えたいときは `min` / `max` を指定する