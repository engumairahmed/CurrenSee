import 'dart:html';

import 'package:currensee/screens/Converter.dart';
import 'package:currensee/screens/FeedBack.dart';
import 'package:currensee/screens/home.dart';
import 'package:flutter/material.dart';

class bottomNavigationBar extends StatefulWidget {
  const bottomNavigationBar({super.key});

  @override
  State<bottomNavigationBar> createState() => _bottomNavigationBarState();
}

class _bottomNavigationBarState extends State<bottomNavigationBar> {
  int myCurrentIndex = 0 ;
  List pages = const[
    HomeScreen(),
    ConverterScreen(),
    FeedBackScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
         appBar: AppBar(
        title: Text(
          "App currency Home",
          style: TextStyle(color: Color.fromARGB(255, 95, 0, 107)),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      backgroundColor: Colors.purple,
bottomNavigationBar: Container(
  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
  decoration: BoxDecoration(boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.3),
    )
  ]),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.purple,
      unselectedItemColor: Colors.black,
      currentIndex: myCurrentIndex,
      onTap: (index){
        setState(() {
          myCurrentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.chat_rounded), label: "Chart"),
        BottomNavigationBarItem(icon: Icon(Icons.local_convenience_store_rounded), label: "Convert"),
        // BottomNavigationBarItem(icon: Icon(Icons.feedback), label: "Feedback"),
        // BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
      ],),
    ),
    ),
    body: pages[myCurrentIndex],
  );
  }
}