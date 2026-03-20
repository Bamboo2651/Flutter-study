import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:project/13_BottomNavigationBar/page_a.dart';
import 'package:project/13_BottomNavigationBar/page_b.dart';
import 'package:project/13_BottomNavigationBar/page_c.dart';

void main() {
  // アプリ
  const app = MaterialApp(home: Root());

  // プロバイダースコープでアプリを囲む
  const scope = ProviderScope(child: app);
  runApp(scope);
}

final indexProvider = StateProvider((ref) {
  // 変化するデータ 0, 1, 2...
  return 0;
});

class Root extends ConsumerWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(indexProvider);
    const items = [
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'アイテム人',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'アイテム家',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'アイテム設定',
      ),
    ];
    final bar = BottomNavigationBar(
      items: items,
      backgroundColor: Colors.red,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      currentIndex: index,
      onTap: (index) {
        ref.read(indexProvider.notifier).state = index;
      },
    );

    final pages = [
      PageA(),
      PageB(),
      PageC(),
    ];
    return Scaffold(body: pages[index], bottomNavigationBar: bar);
  }
}
