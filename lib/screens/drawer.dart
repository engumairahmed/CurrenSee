// import 'package:currensee/attachments/Converter.dart';
import 'package:currensee/screens/currency_converter.dart';
import 'package:currensee/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:currensee/screens/faq_screen.dart';
import 'FeedBack.dart';
// import 'history.dart';
// import 'hom1.dart';

class CustomDrawer extends StatelessWidget {
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
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 134, 47, 47),
                Color.fromARGB(70, 0, 0, 0),
              ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
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
                Text("Laiba",
                  style: TextStyle(fontSize: 22.0, color: Colors.white),
                ),
                Text("Laiba@gmail.com",
                  style: TextStyle(fontSize: 22.0, color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
          Divider(
            color: Colors.grey,
            thickness: 2.0,
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('History'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
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
        ],
      ),
    );
  }
}
