// // import 'package:currency_app/drawer.dart';
// // import 'package:currency_app/drop_down.dart';
import 'dart:async';

import 'package:currensee/ApiTasks.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// // import 'AppBar.dart';
// // import 'BottomNavigation.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({Key? key}) : super(key: key);

  @override
  State<CurrencyConverterScreen> createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  TextEditingController _amount = TextEditingController();
  TextEditingController _rate = TextEditingController();
  TextEditingController _converted = TextEditingController();

  // String result = "";
  // late String rate;

  String _baseCurrency = '';
  String _targetCurrency = '';

  List<String> _currencyCodes = [];

  @override
  void initState() {
    super.initState();
    _fetchCurrencyCodes();
  }

  Future<void> _fetchCurrencyCodes  () async {
    try {
      _currencyCodes = await fetchCurrencyCodes();
      setState(() {
        _baseCurrency = _currencyCodes.isNotEmpty ? _currencyCodes[0] : '';
        _targetCurrency = _currencyCodes.isNotEmpty ? _currencyCodes[0] : '';
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _convert() async {
    try {
      var res =
          await conversionTask(_baseCurrency, _targetCurrency, _amount.text);
      setState(() {
        _rate.text = res["rate"].toString();
        _converted.text = res["amount"].toString();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212936),
      appBar: AppBar(
        title: Text('Currency Converter', ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 200.0,
              child: Text(
                "Currency Converter",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _amount,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "Input Value to Convert",
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18.0,
                    color: Color(0xFF2849E5)
                  ),
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          child: DropdownButtonFormField<String>(
            value: _baseCurrency,
            onChanged: (String? newValue) {
              setState(() {
                _baseCurrency = newValue!;
              });
            },
            items: _currencyCodes.map((String currency) {
              return DropdownMenuItem<String>(
                value: currency,
                child: Text(currency),
              );
            }).toList(),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            ),
          ),
        ),
      ),
    ),
    FloatingActionButton(
      onPressed: () {
        String temp = _baseCurrency;
        setState(() {
          _baseCurrency = _targetCurrency;
          _targetCurrency = temp;
        });
      },
      child: Icon(Icons.swap_horiz),
      elevation: 0.0,
      backgroundColor: Color(0xFF2849E5),
    ),
    SizedBox(
      width: 20.0,
    ),
    Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          child: DropdownButtonFormField<String>(
            value: _targetCurrency,
            onChanged: (String? newValue) {
              setState(() {
                _targetCurrency = newValue!;
              });
            },
            items: _currencyCodes.map((String currency) {
              return DropdownMenuItem<String>(
                value: currency,
                child: Text(currency),
              );
            }).toList(),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            ),
          ),
        ),
      ),
    ),
  ],
),
            SizedBox(
              height: 20.0,
            ),
            // ElevatedButton(
            //   onPressed: _convert,
            //   child: Text('Convert'),
            // ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                ),
                child: Column(children: [
                  Text("Result",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),),
                  Text( _rate.text, style: TextStyle(
                    color: Color(0xFF2849E5),
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                  ), 
                  
                  ),
                   Text("Exchange rates:",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                  ),),
                   Text( _converted.text, style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ), 
                  
                  ),
                
                ],),
                
                
              ),
            ),
             SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _convert,
                child: Text('CONVERT', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),),
                style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF2849E5),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 25, horizontal: 165),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}