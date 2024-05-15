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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
             'lib/images/PNG02.png' ,
             width: 200, // Adjust the width of the logo image
            ),
             SizedBox(height: 20), // Add some spacing between the logo and other content if needed
            //  CircularProgressIndicator(), // Add a loading indicator or any other widgets as needed
          ],
        ),
      ),
    );
  }
}