# Column / Row 編

今回は `const ?? = ??` じゃなくて  
`final ?? = ??` の書き方をする。

---

# Column（カラム）

チルドレンを縦に並べるWidgetです。

![alt text](image.png)

cssと似てる

## コード

```dart
void main() {
  final col = Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [Text("レモン"), Text("リンゴ"), Text("ブドウ")],
  );
  final a = MaterialApp(
    home: Scaffold(body: Center(child: col)),
  );
  runApp(a);
}
```

## 実行結果

![column実行](image-1.png)

---

# Row（ロウ）

チルドレンを横に並べる  
columnと書き方はあまり変わらなくて、

```dart
void main() {
  final col = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [Text("レモン"), Text("リンゴ"), Text("ブドウ")],
  );
  final a = MaterialApp(
    home: Scaffold(body: Center(child: col)),
  );
  runApp(a);
}
```

## 実行結果

![row実行](image-2.png)

---

# コンパクトにする

```dart
void main() {
  final col = Column(
    mainAxisSize: MainAxisSize.min,
    children: [Text("レモン"), Text("リンゴ"), Text("ブドウ")],
  );
  final a = MaterialApp(
    home: Scaffold(body: Center(child: col)),
  );
  runApp(a);
}
```

`mainAxisSize: MainAxisSize.min`  
サイズの最小限になる