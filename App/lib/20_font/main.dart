import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  const a = MyApp();
  runApp(a);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'フラッター',
          style: GoogleFonts.NotoSerifJapanese(),
        ),
      ),
    );
  }
}
