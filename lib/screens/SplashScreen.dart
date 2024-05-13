import 'package:currensee/Preferences.dart';
import 'package:currensee/navigation.dart';
import 'package:currensee/screens/login.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn=false;
  Future<void> checkUser() async{
    var id = await getUser();
    if(id == null){
      setState(() {        
      isLoggedIn = false;
      });
    } else{
      setState(() {
      isLoggedIn = true;        
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Add any initialization logic here, such as loading data or animations
    // After a delay, navigate to the main screen
    checkUser();
    if(isLoggedIn){
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPageScreen()),
      );
    });  
    } else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const bottomNavigationBar()));
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
             'https:mail.google.com/mail/u/0/#inbox/FMfcgzGxSvBlvffWmCzTvpfZxSLnXpDr?projector=1&messagePartId=0.1' ,
             width: 200, // Adjust the width of the logo image
            ),
            const SizedBox(height: 20), // Add some spacing between the logo and other content if needed
            const CircularProgressIndicator(), // Add a loading indicator or any other widgets as needed
          ],
        ),
      ),
    );
  }
}