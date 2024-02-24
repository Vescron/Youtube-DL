// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('To-Do',
            style: TextStyle(fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.teal)
            ),
            Text('Add playlists feature'),
            Text('Add settings'),
            Text('Add download history'),
            Text('Add download queue'),
          ],
        )
      ),
    );
  }
}