import 'package:currensee/ApiTasks.dart';
import 'package:currensee/navigation.dart';
import 'package:flutter/material.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  
  TextEditingController _baseCurrency = TextEditingController();
  TextEditingController _targertCurrency = TextEditingController();
  TextEditingController _amount = TextEditingController();
  TextEditingController _rate = TextEditingController();
  TextEditingController _converted = TextEditingController();

  Future<void> convert() async{
    var res = await conversionTask(_baseCurrency.text,_targertCurrency.text,_amount.text);
    // print(res);
    setState(() {
      _rate.text=res["rate"].toString();
      _converted.text=res["amount"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Form(child: Column(
        children: [
          TextFormField(
            controller: _baseCurrency,
            decoration: InputDecoration(label: Text("Base Currency")),
          ),
          TextFormField(
            controller: _targertCurrency,
            decoration: InputDecoration(label: Text("Target Currency")),
          ),
          TextFormField(
            controller: _amount,
            decoration: InputDecoration(label: Text("Amount")),
          ),
          TextFormField(
            controller: _rate,
            decoration: InputDecoration(label: Text("Rate")),
          ),
          TextFormField(
            controller: _converted,
            decoration: InputDecoration(label: Text("Converted Amount")),
          ),
          ElevatedButton(onPressed: convert, child: Text("Convert"))
        ],
      )),
    );
  }
}