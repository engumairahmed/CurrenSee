

import 'dart:convert';
import 'package:currensee/screens/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CurrencyPage extends StatefulWidget {
  @override
  _CurrencyPageState createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  List<dynamic> currencies = [
    {
      'title': 'Title',
     'subtitle': 'Values',
      // You can customize the ListTile to display more information as needed
    },  
  ];

  @override
  void initState() {
    super.initState();
    // fetchCurrencyData();
  }

  Future<void> fetchCurrencyData() async {
    try {
      final response = await http.get(Uri.parse('URL_OF_OTHER_PAGE'));
      if (response.statusCode == 200) {
        setState(() {
          currencies = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load currency data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Data'),
      ),
      drawer: CustomDrawer(),
      body: currencies.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: currencies.length,
              itemBuilder: (context, index) {
                final currency = currencies[index];
                return ListTile(
                  title: Text('Title'),
                  subtitle: Text('Values'),

                  // You can customize the ListTile to display more information as needed
                );
              },
            ),
    );
  }
}











