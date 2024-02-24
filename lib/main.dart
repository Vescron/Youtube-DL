// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:youtube_dl/pages/main_page.dart';
import 'package:dynamic_color/dynamic_color.dart';

void main() {
  runApp(const MyApp());
}

final defaultColorScheme =ColorScheme.fromSwatch(
  primarySwatch: Colors.lightGreen,
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme,darkColorScheme){
      return  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Youtube DL',
        home: MainPage(),
        theme: ThemeData(
          colorScheme: lightColorScheme ?? defaultColorScheme,
          useMaterial3: true),
        darkTheme: ThemeData(
          colorScheme: darkColorScheme ?? defaultColorScheme,
          useMaterial3: true),
        themeMode: ThemeMode.dark, 
    );
    }
  );
  }
}
