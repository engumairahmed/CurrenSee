

import 'package:currensee/firebase_options.dart';
import 'package:currensee/screens/AppBar.dart';
import 'package:currensee/screens/navigation.dart';
import 'package:currensee/screens/converter.dart';
import 'package:currensee/screens/currency_converter.dart';
import 'package:currensee/screens/faq_screen.dart';
import 'package:currensee/screens/feedback.dart';
import 'package:currensee/screens/splash_screen.dart';

import 'package:currensee/screens/chart.dart';
import 'package:currensee/screens/login.dart';
import 'package:currensee/screens/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
     options: DefaultFirebaseOptions.android,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}