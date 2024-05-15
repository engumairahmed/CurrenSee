import 'package:currensee/login.dart';
import 'package:currensee/navigation.dart';
import 'package:currensee/screens/FaqScreen.dart';
import 'package:currensee/screens/FeedBack.dart';
import 'package:currensee/screens/SplashScreen.dart';
import 'package:currensee/screens/chart.dart';
import 'package:currensee/screens/login.dart';
import 'package:currensee/register.dart';
import 'package:currensee/screens/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
