// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_dl/pages/home.dart';
import 'package:youtube_dl/pages/info.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> pages = [
    Home(),
    Info(),
  ];

int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentIndex = index;
          });   
        },
       // indicatorColor: Color.fromARGB(255, 255, 209, 209),
        selectedIndex: currentIndex,
       // backgroundColor: Color.fromARGB(255, 255, 246, 145),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.info_outline_rounded),
            label: 'Info',
          ),],
      ),
      appBar: AppBar(
        leading: Icon(Icons.play_circle_fill_rounded, color: Colors.red[200], size: 40,shadows: [
          Shadow(blurRadius: 3.0,
              color: Color.fromARGB(255, 193, 173, 173).withOpacity(0.8),
              offset: Offset(0.0, 0.0),),
          // Shadow(
          //     blurRadius: 5.0,
          //     color: Color.fromARGB(255, 255, 255, 255).withOpacity(1),
          //     offset: Offset(1.0, 0.0),
          //   ),
        ],),
        centerTitle: true,
        elevation: 0,
        title: Text('TestVersion',
        style: GoogleFonts.inter(
        textStyle: TextStyle(
          color: Colors.red[200],
          fontSize: 30,
          shadows: [
            Shadow(
              blurRadius: 5.0,
              color: Color.fromARGB(255, 193, 173, 173).withOpacity(0.8),
              offset: Offset(0.0, 0.0),
            ),
          ],
          fontWeight: FontWeight.bold,
        ),),
        ),
       // backgroundColor: Color.fromARGB(255, 255, 253, 134),
        ),
      body: IndexedStack(
        index : currentIndex,
        children: pages,
      ),
    );
  }
}