import 'dart:async'; // Importing Dart async package
import 'dart:ui'; // Importing Dart UI package

import 'package:currensee/api_tasks.dart'; // Importing API tasks
import 'package:currensee/app_properties.dart'; // Importing app properties for styling
import 'package:currensee/screens/AppBar.dart'; // Importing custom app bar
import 'package:flutter/material.dart'; // Importing Flutter material package

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({Key? key}) : super(key: key);

  @override
  State<CurrencyConverterScreen> createState() => _CurrencyConverterScreenState(); // Creating state for CurrencyConverterScreen
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  TextEditingController _amount = TextEditingController(); // Controller for amount input
  TextEditingController _rate = TextEditingController(); // Controller for exchange rate display
  TextEditingController _converted = TextEditingController(); // Controller for converted amount display

  String _baseCurrency = ''; // Variable to store base currency
  String _targetCurrency = ''; // Variable to store target currency

  List<String> _currencyCodes = []; // List to store currency codes

  @override
  void initState() {
    super.initState();
    _fetchCurrencyCodes(); // Fetch currency codes on initialization
  }

  Future<void> _fetchCurrencyCodes() async {
    try {
      _currencyCodes = await fetchCurrencyCodes(); // Fetch currency codes from API
      setState(() {
        _baseCurrency = _currencyCodes.isNotEmpty ? _currencyCodes[0] : ''; // Set default base currency
        _targetCurrency = _currencyCodes.isNotEmpty ? _currencyCodes[0] : ''; // Set default target currency
      });
    } catch (e) {
      print(e.toString()); // Print error if fetching currency codes fails
    }
  }

  Future<void> _convert() async {
    try {
      var res = await conversionTask(_baseCurrency, _targetCurrency, _amount.text); // Perform conversion task
      setState(() {
        _rate.text = res["rate"].toString(); // Set exchange rate
        _converted.text = res["amount"].toString(); // Set converted amount
      });
    } catch (e) {
      print(e.toString()); // Print error if conversion fails
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundAppBar(pageTitle: 'Convert'), // Custom app bar with title 'Convert'
      body: Container(
        decoration: BoxDecoration(
          gradient: ColorProperties.mainColor, // Applying gradient background
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding around the entire column
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Align items to the start of the column
            crossAxisAlignment: CrossAxisAlignment.start, // Align items to the start (left) of the column
            children: [
              SizedBox(
                height: 20.0, // Spacer
              ),
              Padding(
                padding: const EdgeInsets.all(8.0), // Padding around the text field
                child: TextField(
                  controller: _amount, // Controller for amount input
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rounded border
                      borderSide: BorderSide(color: Colors.black), // Border color
                    ),
                    fillColor: Colors.white, // Fill color for text field
                    filled: true, // Enable fill color
                    labelText: "Input Value to Convert", // Label text
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18.0,
                      color: ColorProperties.secondColor, // Label text color
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black, // Text color
                    fontSize: 24.0, // Text size
                    fontWeight: FontWeight.bold, // Text weight
                  ),
                  textAlign: TextAlign.center, // Center text alignment
                  keyboardType: TextInputType.number, // Numeric keyboard
                ),
              ),
              SizedBox(
                height: 20.0, // Spacer
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between the two dropdowns and button
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0), // Padding around the dropdown
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // Background color
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0), // Rounded border
                          ),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: _baseCurrency, // Value for base currency dropdown
                          onChanged: (String? newValue) {
                            setState(() {
                              _baseCurrency = newValue!; // Set new base currency
                            });
                          },
                          items: _currencyCodes.map((String currency) {
                            return DropdownMenuItem<String>(
                              value: currency,
                              child: Text(currency), // Dropdown item text
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: InputBorder.none, // No border
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15), // Padding inside dropdown
                          ),
                        ),
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      String temp = _baseCurrency;
                      setState(() {
                        _baseCurrency = _targetCurrency; // Swap base and target currencies
                        _targetCurrency = temp;
                      });
                    },
                    child: Icon(Icons.swap_horiz), // Swap icon
                    elevation: 0.0, // No elevation
                    backgroundColor: Color(0xFF2849E5), // Button color
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0), // Padding around the dropdown
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // Background color
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0), // Rounded border
                          ),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: _targetCurrency, // Value for target currency dropdown
                          onChanged: (String? newValue) {
                            setState(() {
                              _targetCurrency = newValue!; // Set new target currency
                            });
                          },
                          items: _currencyCodes.map((String currency) {
                            return DropdownMenuItem<String>(
                              value: currency,
                              child: Text(currency), // Dropdown item text
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: InputBorder.none, // No border
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15), // Padding inside dropdown
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0, // Spacer
              ),
              SizedBox(
                height: 20.0, // Spacer
              ),
              Padding(
                padding: const EdgeInsets.all(8.0), // Padding around the result container
                child: Container(
                  width: double.infinity, // Full width container
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.0), // Rounded border
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Result",
                        style: TextStyle(
                          color: Colors.black, // Text color
                          fontSize: 24.0, // Text size
                          fontWeight: FontWeight.bold, // Text weight
                        ),
                      ),
                      Text(
                        _converted.text, // Display converted amount
                        style: TextStyle(
                          color: ColorProperties.firstColor, // Text color
                          fontSize: 36.0, // Text size
                          fontWeight: FontWeight.bold, // Text weight
                        ),
                      ),
                      Text(
                        "Exchange rates:",
                        style: TextStyle(
                          color: Colors.black, // Text color
                          fontSize: 18.0, // Text size
                          fontWeight: FontWeight.normal, // Text weight
                        ),
                      ),
                      Text(
                        _rate.text, // Display exchange rate
                        style: TextStyle(
                          color: Colors.black, // Text color
                          fontSize: 18.0, // Text size
                          fontWeight: FontWeight.bold, // Text weight
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0, // Spacer
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0), // Padding around the button
                  child: ElevatedButton(
                    onPressed: _convert, // Handle conversion on tap
                    child: Text(
                      'CONVERT',
                      style: TextStyle(
                          color: Colors.white, // Text color
                          fontSize: 20, // Text size
                          fontWeight: FontWeight.bold), // Text weight
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 20, // Button elevation
                      shadowColor: Colors.white, // Shadow color
                      padding: EdgeInsets.symmetric(
                          vertical: 25, horizontal: 80), // Padding inside button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0), // Rounded border
                      ),
                      backgroundColor: Color(0xFF00203F), // Button color
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
