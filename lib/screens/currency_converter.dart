
import 'dart:async'; // Importing Dart async package
import 'dart:js_interop';// Importing Dart async package
import 'dart:ui'; // Importing Dart UI package

import 'package:currensee/api_tasks.dart'; // Importing API tasks
import 'package:currensee/app_properties.dart';//  Importing app properties for styling
import 'package:currensee/preferences.dart'; // Importing preference
import 'package:currensee/screens/AppBar.dart'; // Importing custom app bar
import 'package:flutter/material.dart'; // Importing Flutter material package



class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({Key? key}) : super(key: key);

  @override
  State<CurrencyConverterScreen> createState() => _CurrencyConverterScreenState(); // Creating state for CurrencyConverterScreen
}
class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {

  TextEditingController _amount = TextEditingController();
  TextEditingController _rate = TextEditingController();
  TextEditingController _converted = TextEditingController();

  String _baseCurrency = '';
  String _targetCurrency = '';

  List<String> _currencyCodes = [];

  @override
  void initState() {
    super.initState();
    _fetchCurrencyCodes();
    print('Currency Converter launched');
  }

  Future<void> _fetchCurrencyCodes() async {
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
      var id = await getUser();
      var res =
          await conversionTask(_baseCurrency, _targetCurrency, _amount.text,id!);
          print(res);
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
      appBar: RoundAppBar(pageTitle: 'Convert',buildContext: context,),
      body:
      Container(
        decoration: BoxDecoration(
            // gradient: ColorProperties.mainColor,
        ),
 
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _amount,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "Input Value to Convert",
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18.0,
                      color: ColorProperties.darkColor),
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
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
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
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
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
                child: Column(
                  children: [
                    Text(
                      "Result",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _converted.text,
                      style: TextStyle(
                        color: ColorProperties.firstColor,
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Exchange rates:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      _rate.text,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: _convert,
                    child: Text(
                      'CONVERT',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 20,
                      shadowColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 25, horizontal: 80),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                         backgroundColor:  Color(0xFF00203F), 
                    )),
              ),
            ),
          ],
        ),
      ),
      )
    );
  }
}