import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main(List<String> args) {
  const app = MaterialApp(home: Home());
  const scope = ProviderScope(child: app);
  runApp(scope);
}

final isOnProvider = StateProvider((ref) {
  return true; //オンの状態から始まるスイッチ
});

final valuProvider = StateProvider((ref) {
  return 0.0;
});
final rangeProvider = StateProvider((ref) {
  return const RangeValues(0.0, 1.0);
});

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOn = ref.watch(isOnProvider);
    final toggleSwitch = Switch(
      value: isOn,
      onChanged: (isOn) {
        ref.read(isOnProvider.notifier).state = isOn;
      },
      activeThumbColor: Colors.blue,
      activeTrackColor: Colors.green,
      inactiveThumbColor: Colors.black,
      inactiveTrackColor: Colors.grey,
    );
    final value = ref.watch(valuProvider);
    final slider = Slider(
      value: value,
      onChanged: (value) {
        ref.read(valuProvider.notifier).state = value;
      },
      thumbColor: Colors.blue,
      activeColor: Colors.green,
      inactiveColor: Colors.black12,
    );
    final range = ref.watch(rangeProvider);
    final rangeSlider = RangeSlider(
      values: range,
      onChanged: (value) {
        ref.read(rangeProvider.notifier).state = value;
      },
      // 色を変える
      activeColor: Colors.green,
      inactiveColor: Colors.black12,
    );
    final con = Container(
      width: value * 400,
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
