
import 'package:currensee/app_properties.dart';
import 'package:currensee/screens/FeedBack.dart';
import 'package:currensee/screens/conversion_history.dart';
import 'package:currensee/screens/user_preferences.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
      ),
      body: Container(
        height: 190, // Set a fixed height for the container to hold the ListView
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.all(20.0),
          children: [
            _buildCard(context, 'History', ColorProperties.mainColor, Icons.history, ConversionHistory()),
            SizedBox(width: 20.0),
            _buildCard(context, 'Feedback', ColorProperties.mainColor, Icons.help, const FeedBackScreen()),
            SizedBox(width: 20.0),
            _buildCard(context, 'Settings', ColorProperties.mainColor, Icons.settings, UserPreferences()),            
            SizedBox(width: 20.0),
            _buildCard(context, 'Feedback', ColorProperties.mainColor, Icons.settings, UserPreferences()),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, Gradient gradient, IconData icon, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        // height: 50,
        width: 95, // Set a fixed width for the card
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          gradient: gradient,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 4),
              blurRadius: 5.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


