import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/19_json/vegetable.dart';

void main() {
  test1();
}

void test1() async {
  WidgetsFlutterBinding.ensureInitialized();
  final json = await rootBundle.loadString('stub/level1.json');
  final map = jsonDecode(json);
  final data = Vegetable.fromJson(map);
  debugPrint('データの中身は $data');
}

void test2() async {}
void test3() async {}
void test4() async {}
void test5() async {}
void test6() async {}
void test7() async {}
void test8() async {}
void test9() async {}
void test10() async {}
