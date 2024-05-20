import 'package:currensee/Preferences.dart';
import 'package:currensee/app_properties.dart';
import 'package:currensee/google_auth_service.dart';
import 'package:currensee/screens/Converter.dart';
import 'package:currensee/screens/FeedBack.dart';
import 'package:currensee/screens/chart.dart';
import 'package:currensee/screens/currency_converter.dart';
import 'package:currensee/screens/faq_screen.dart';
import 'package:currensee/screens/home.dart';
import 'package:currensee/screens/login.dart';
import 'package:flutter/material.dart';
// import 'history.dart';
// import 'hom1.dart';

class CustomDrawer extends StatelessWidget {

  AuthService _authService = new AuthService();
  
  String userName="";
  String userEmail="";

  Future<void> showUserProfile() async {
    var user = await getUserData();
    var id = await getUser();
    userName=user.name;
    userEmail=user.email;
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              gradient: ColorProperties.mainColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

             children: [
                CircleAvatar(
                  radius: 40.0,
                  backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLHS121TqtsuRK7rS3D9U0qY4EhvhUhNwKrD8_zq9QUg&s"),
                ),
                SizedBox(height: 5.0,),
                Text(userName,
                  style: TextStyle(fontSize: 22.0, color: Colors.white),
                ),
                Text(userEmail,
                  style: TextStyle(fontSize: 22.0, color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('History'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChartScreen()),
              );
            },
          ),
          Divider(
            color: Colors.grey,
            thickness: 2.0,
          ),
          ListTile(
            leading: Icon(Icons.currency_exchange),
            title: Text('Converter'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CurrencyConverterScreen()),
              );
            },
          ),
          Divider(
            color: Colors.grey,
            thickness: 2.0,
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('FeedBack'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FeedBackScreen()),
              );
            },
          ),
          Divider(
            color: Colors.grey,
            thickness: 2.0,
          ),
          ListTile(
            leading: Icon(Icons.question_answer),
            title: Text('Faq'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FAQScreen()),
              );
            },
          ),

          Expanded(child: Container()),

          Divider(
            color: Colors.grey,
            thickness: 2.0,
          ),
          ListTile(
            leading: Icon(Icons.logout_rounded),
            title: Text('Logout'),
            onTap: (){
              showLogoutConfirmationDialog(context);
              },
          ),

        ],
      ),
    );
  }
  
    Future<void> showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to logout?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Logout', style: TextStyle(color: Colors.red)),
              onPressed: () async {
                Navigator.of(context).pop();
                await _authService.signOut(); // This function should clear stored user data
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPageScreen()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

}
