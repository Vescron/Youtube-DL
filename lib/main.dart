// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:youtube_dl/pages/home.dart';
import 'package:youtube_dl/pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Youtube DL',
      home: MainPage(),
      theme: ThemeData(useMaterial3: true),
  );
  }
}
