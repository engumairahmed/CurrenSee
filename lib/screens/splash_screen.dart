
import 'package:currensee/preferences.dart'; // Importing preferences for user data
import 'package:currensee/app_properties.dart'; // Importing app properties for styling
import 'package:currensee/screens/bottom_navigation.dart';// Importing navigation screen
import 'package:currensee/screens/auth/login.dart'; // Importing login screen
import 'package:flutter/material.dart'; // Importing Flutter material package
import 'package:lottie/lottie.dart'; // Importing Lottie for animations


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState(); // Creating state for SplashScreen
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false; // Variable to check if the user is logged in

  // Function to check if the user is logged in
  Future<void> checkUser() async {
    var id = await getUser(); // Getting user id from preferences
    if (id == null) {
      setState(() {
        isLoggedIn = false; // User is not logged in
      });
    } else {
      setState(() {
        isLoggedIn = true; // User is logged in
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // Checking user login status then navigating to appropriate screen
    print("Splash Screen");
    // checkUser() then navigate to appropriate screen

    checkUser().then((_) {
      // After a delay of 3 seconds, navigate to the main screen or login screen based on login status
      if (isLoggedIn) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const bottomNavigationBar()), // Navigate to bottomNavigationBar if logged in
          );
        });
      } else {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPageScreen()), // Navigate to LoginPageScreen if not logged in
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorProperties.darkColor, // Setting background color
      body: Container(
        decoration: BoxDecoration(
          gradient: ColorProperties.mainColorCross, // Applying gradient background
        ),
        child: Center(
          child: Lottie.asset('lib/images/logo.json'), // Displaying logo animation
        ),
      ),
    );
  }
}