import 'package:currensee/preferences.dart';
import 'package:currensee/app_properties.dart';
import 'package:currensee/screens/bottom_navigation.dart';
import 'package:currensee/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn=false;

  Future<void> checkUser() async{
    User? user = FirebaseAuth.instance.currentUser;
    var id = await getUser();
    if(id != null || user != null){
      setState(() {        
      isLoggedIn = true;
      });
    } else{
      setState(() {
      isLoggedIn = false;        
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print("Splash Screen");
    // checkUser() then navigate to appropriate screen
    checkUser().then((_) {

    // After a delay, navigate to the main screen
    if (isLoggedIn) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const bottomNavigationBar()),
        );
      });
    } else {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPageScreen()),
        );
      });
    }
  });  
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorProperties.darkColor,
      body: Container(
        decoration: BoxDecoration(
            gradient: ColorProperties.mainColorCross,
          ),
        child: Center(
          child: Lottie.asset('lib/images/logo.json'),
        ),
      ),
    );
  }
}