フレーバー
d s p 
開発　試験版　製品版にわける
dev stg prd
なぜ分ける
安心して開発ができる。
scriptsフォルダを作る
ターミナルにコマンドを入力して実行する
flutter run -d chrome --dart-define-from-file=scripts/flavors/dev.json
このコマンドを使うときはmain.dart をlibの直下に置く必要がある。lib/main.dart
毎回長いコマンドを入力するのはめんどくさいので、左側の実行ボタンでdev stg prd を選んで実行する。
止めるときは ctl + cで止める

if 文
if (flavor == 'dev'){
devのときだけ使える
}