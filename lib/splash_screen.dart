import 'dart:async';
import 'package:flutter/material.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), (){

      Navigator.pushReplacement(
        context, 
      MaterialPageRoute(
      builder: (context) => const LoginScreen(),
      ));

  });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 118, 51, 170),
                Color.fromARGB(255, 215, 15, 233),
              ]
          ),
        ),
        child: const Padding(
          padding:  EdgeInsets.only(top: 40.0, left: 22),
          child: Text('Welcome To Login!', style: TextStyle(
            fontSize: 40,
            fontFamily: AutofillHints.birthday,
            color: Colors.white,
            fontWeight: FontWeight.bold

          ),),
        ),
      ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),topRight: Radius.circular(40)
            ),

              color: Colors.white,
            ),
              height: double.infinity,
              width: double.infinity,
                
                    
               
                  ),
              ),
          
],
        ));
    
  }
}