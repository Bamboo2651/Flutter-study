# Radio / Checkbox の基礎

## 今回学ぶ Widget

| Widget | 説明 |
|--------|------|
| `RadioListTile` | 複数の選択肢から1つだけ選ぶ |
| `CheckboxListTile` | 複数の選択肢から複数選べる |

---

## RadioとCheckboxの違い

```
ラジオボタン → どれか1つだけ選べる（性別・支払い方法など）
チェックボックス → 複数選べる（趣味・好きな食べ物など）
```

---

## コード全体

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

void main() {
  const app = MaterialApp(home: Home());
  const scope = ProviderScope(child: app);
  runApp(scope);
}

// 選ばれたラジオボタンのID（1つだけなのでStringで管理）
final radioIdProvider = StateProvider<String?>((ref) {
  return null; // 最初はどれも選ばれていない
});

// 選ばれたチェックボックスのIDたち（複数なのでSetで管理）
final checkedIdsProvider = StateProvider<Set<String>>((ref) {
  return {}; // 最初は空っぽ
});

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radioId = ref.watch(radioIdProvider);
    final checkedIds = ref.watch(checkedIdsProvider);

    // ラジオボタンが押されたとき
    void onChangedRadio(String? id) {
      ref.read(radioIdProvider.notifier).state = id!;
    }

    // チェックボックスが押されたとき
    void onChangedCheckbox(String id) {
      final newSet = Set.of(checkedIds);
      if (checkedIds.contains(id)) {
        newSet.remove(id); // すでに選ばれていたら外す
      } else {
        newSet.add(id);    // 選ばれていなければ追加
      }
      ref.read(checkedIdsProvider.notifier).state = newSet;
    }

    final col = Column(
      children: [
        // ラジオボタン
        RadioGroup(
          groupValue: radioId,
          onChanged: onChangedRadio,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile(value: 'A', title: const Text('ラジオボタンA')),
              RadioListTile(value: 'B', title: const Text('ラジオボタンB')),
              RadioListTile(value: 'C', title: const Text('ラジオボタンC')),
            ],
          ),
        ),

        // チェックボックス
        CheckboxListTile(
          onChanged: (check) => onChangedCheckbox('A'),
          value: checkedIds.contains('A'),
          title: const Text('チェックボックスA'),
        ),
        CheckboxListTile(
          onChanged: (check) => onChangedCheckbox('B'),
          value: checkedIds.contains('B'),
          title: const Text('チェックボックスB'),
        ),
        CheckboxListTile(
          onChanged: (check) => onChangedCheckbox('C'),
          value: checkedIds.contains('C'),
          title: const Text('チェックボックスC'),
        ),

        // OKボタン
        ElevatedButton(
          onPressed: () {
            debugPrint(radioId);               // 選ばれたラジオボタンのID
            debugPrint(checkedIds.toString()); // 選ばれたチェックボックスのID一覧
          },
          child: const Text('OK'),
        ),
      ],
    );

    return Scaffold(body: col);
  }
}
```

---

## 各パーツの解説

### Provider の型

```dart
// ラジオ → 1つだけなので String?（nullあり）
final radioIdProvider = StateProvider<String?>((ref) => null);

// チェックボックス → 複数なので Set<String>
final checkedIdsProvider = StateProvider<Set<String>>((ref) => {});
```

| | ラジオ | チェックボックス |
|---|---|---|
| 選べる数 | 1つだけ | 複数 |
| 管理する型 | `String?` | `Set<String>` |
| 初期値 | `null` | `{}` |

---

### RadioGroup / RadioListTile

```dart
RadioGroup(
  groupValue: radioId,       // 現在選ばれているID
  onChanged: onChangedRadio, // 選択が変わったときの処理
  child: Column(
    children: [
      RadioListTile(value: 'A', title: const Text('ラジオボタンA')),
      RadioListTile(value: 'B', title: const Text('ラジオボタンB')),
      RadioListTile(value: 'C', title: const Text('ラジオボタンC')),
    ],
  ),
)
```

- `RadioGroup` でグループ全体を囲む
- `groupValue` に現在選ばれているIDを渡す
- `RadioListTile` の `value` が `groupValue` と一致したものが選択状態になる

---

### CheckboxListTile

```dart
CheckboxListTile(
  value: checkedIds.contains('A'), // Aが選ばれているか
  onChanged: (check) => onChangedCheckbox('A'),
  title: const Text('チェックボックスA'),
)
```

- `value` に `true` / `false` を渡す
- `checkedIds.contains('A')` で「AがSetに含まれているか」を確認している

---

### チェックボックスのオン/オフ処理

```dart
void onChangedCheckbox(String id) {
  final newSet = Set.of(checkedIds); // 現在のSetをコピー
  if (checkedIds.contains(id)) {
    newSet.remove(id); // すでに選ばれていたら外す
  } else {
    newSet.add(id);    // 選ばれていなければ追加
  }
  ref.read(checkedIdsProvider.notifier).state = newSet;
}
```

> Riverpod の State を直接変更できないので、一度 `Set.of()` でコピーしてから更新している。

---

## Set とは

重複を許さないリスト。同じIDが2回入ることがない。

```dart
final set = {'A', 'B', 'C'};
set.add('A');    // すでにあるので変化なし → {'A', 'B', 'C'}
set.remove('B'); // 削除 → {'A', 'C'}
set.contains('A'); // true
```

---

## 選択結果の確認

OKボタンを押すとターミナルに出力される。

```
// ラジオボタンでBを選んだ場合
B

// チェックボックスでAとCを選んだ場合
{A, C}
```

---

## ポイントまとめ

- ラジオボタンは `String?` で1つだけ管理、チェックボックスは `Set<String>` で複数管理
- `RadioGroup` でラジオボタンをまとめて囲む
- `groupValue` と `value` が一致したラジオボタンが選択状態になる
- チェックボックスは `contains()` で選択状態を確認し、`add()` / `remove()` で切り替える
- Riverpod の State を更新するときは `Set.of()` でコピーしてから変更する