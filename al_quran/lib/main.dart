import 'package:al_quran/HomePage/home_page.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(const AlQuranApp());
}

class AlQuranApp extends StatelessWidget {
  const AlQuranApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
