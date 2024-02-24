// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Info extends StatelessWidget {
  Info({super.key});

  final List taskList = [
    'Add playlists feature',
    'Add settings',
    'Add download history',
    'Add download queue',
    'Add download preview',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          //mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('To-Do',
                style: GoogleFonts.montserrat(fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.teal)
                ),
            Expanded(
              child: ListView.builder(
              shrinkWrap: true,
              itemCount: taskList.length,
              itemBuilder: (context, index){
              return Padding(padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    taskList[index],
                    style: GoogleFonts.poppins(
                      fontSize:18,
                    ),))
                ),
              );
            },
            )
            ),
          ],
        ),
    );
  }
}