import 'package:currensee/screens/FeedBack.dart';
import 'package:currensee/screens/chart.dart';
import 'package:flutter/material.dart';
import 'package:currensee/screens/currency_converter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LinearGradient mainColor = const LinearGradient(
    colors: [
      Color(0xFF00203F),
      Color(0xFFADEFD1),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              _buildCard(context, 'Converter', mainColor, Icons.compare_arrows, CurrencyConverterScreen()),
              SizedBox(height: 20.0),
              _buildCard(context, 'Historical Rates', mainColor, Icons.show_chart, ChartScreen()),
              SizedBox(height: 20.0),
              _buildCard(context, 'History', mainColor, Icons.history, FeedBackScreen()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, Gradient gradient, IconData icon, Widget page) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => page));
        },
        child: Container(
          height: 150,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            gradient: gradient,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
