import 'package:flutter/material.dart';



class HomeScreen extends StatelessWidget {
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
              _buildCard(context, 'Converter', mainColor, Icons.compare_arrows, ConverterPage()),
              SizedBox(height: 20.0),
              _buildCard(context, 'Rates', mainColor, Icons.show_chart, RatesPage()),
              SizedBox(height: 20.0),
              _buildCard(context, 'History', mainColor, Icons.history, HistoryPage()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, LinearGradient gradient, IconData icon, Widget page) {
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

class ConverterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Converter'),
      ),
      body: Center(
        child: Text('Converter Page'),
      ),
    );
  }
}

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: Center(
        child: Text('History Page'),
      ),
    );
  }
}

class RatesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rates'),
      ),
      body: Center(
        child: Text('Rates Page'),
      ),
    );
  }
}
