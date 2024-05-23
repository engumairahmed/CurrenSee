import 'dart:async'; // Importing Dart async package
import 'package:currensee/api_tasks.dart'; // Importing API tasks
import 'package:currensee/app_properties.dart'; // Importing app properties for styling
import 'package:currensee/preferences.dart'; // Importing preference
import 'package:currensee/screens/AppBar.dart'; // Importing custom app bar
import 'package:flutter/material.dart'; // Importing Flutter material package

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({Key? key}) : super(key: key);

  @override
  State<CurrencyConverterScreen> createState() =>
      _CurrencyConverterScreenState(); // Creating state for CurrencyConverterScreen
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  TextEditingController _amount = TextEditingController();
  TextEditingController _rate = TextEditingController();
  TextEditingController _converted = TextEditingController();

  String _baseCurrency = '';
  String _targetCurrency = '';

  List<String> _currencyCodes = [];

  Future<void> _fetchCurrencyCodes() async {
    try {
      var currencyCodes = await getCurrencyCodes();
      if (currencyCodes.isEmpty) {
        currencyCodes = await fetchCurrencyCodes();
        if (currencyCodes.isEmpty) {
          _currencyCodes = [];
        } else {
          await setCurrencyCodes(currencyCodes);
          setState(() {
            _currencyCodes = currencyCodes;
            _baseCurrency = _currencyCodes.isNotEmpty ? _currencyCodes[0] : '';
            _targetCurrency =
                _currencyCodes.isNotEmpty ? _currencyCodes[0] : '';
          });
        }
      } else {
        setState(() {
          _currencyCodes = currencyCodes;
          _baseCurrency = _currencyCodes.isNotEmpty ? _currencyCodes[0] : '';
          _targetCurrency = _currencyCodes.isNotEmpty ? _currencyCodes[0] : '';
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
    }
  }

  Future<void> _convert() async {
    try {
      var id = await getUser();
      var res = await conversionTask(
          _baseCurrency, _targetCurrency, _amount.text, id!);
      setState(() {
        _rate.text = res["rate"].toString();
        _converted.text = res["amount"].toString();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCurrencyCodes();
    _amount.text = '1';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _amount.dispose();
    _rate.dispose();
    _converted.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundAppBar(pageTitle: 'Convert', buildContext: context),
      body: _currencyCodes.isEmpty
          ? Center(
              child: CircularProgressIndicator(
              color: ColorProperties.lightColor2,
            ))
          : Container(
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
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorProperties.darkColor, width: 2),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: "Amount to Convert",
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
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorProperties.darkColor,
                                          width: 2),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15),
                                    labelText: 'Base Currency',
                                    focusColor: ColorProperties.darkColor,
                                    labelStyle: TextStyle(
                                      color: ColorProperties.darkColor,
                                    )),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            String temp = _baseCurrency;
                            setState(() {
                              _baseCurrency = _targetCurrency;
                              _targetCurrency = temp;
                            });
                          },
                          icon: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: ColorProperties.mainColorCross,
                            ),
                            child: Icon(Icons.swap_horiz_outlined,
                                size: 50, color: Colors.white),
                          ),
                          color: Colors.transparent,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          padding: EdgeInsets.all(16),
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
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorProperties.darkColor,
                                          width: 2),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15),
                                    labelText: 'Target Currency',
                                    focusColor: ColorProperties.darkColor,
                                    labelStyle: TextStyle(
                                      color: ColorProperties.darkColor,
                                    )),
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
                          gradient: ColorProperties.mainColorCross,
                          border: Border.all(
                              width: 1, color: ColorProperties.darkColor),
                          borderRadius: BorderRadius.all(
                            Radius.circular(16.0),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Result",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _converted.text,
                              style: TextStyle(
                                color: Colors.white,
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
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: ColorProperties.mainColorCross,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: ElevatedButton(
                            onPressed: _convert,
                            child: Text(
                              'CONVERT',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              padding: EdgeInsets.symmetric(
                                  vertical: 25, horizontal: 80),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
