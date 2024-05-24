import 'package:currensee/api_tasks.dart';
import 'package:currensee/app_properties.dart';
import 'package:currensee/models/currency_model.dart';
import 'package:flutter/material.dart';

class SupportedCurrencies extends StatefulWidget {
  const SupportedCurrencies({super.key});

  @override
  State<SupportedCurrencies> createState() => _SupportedCurrenciesState();
}

class _SupportedCurrenciesState extends State<SupportedCurrencies> {

  List<CurrencyModel> _currencies = [];

  Future<void> _getCurrencyList() async {
    var result = await getCurrencyList();
    if (result.isEmpty) {
      setState(() {
        _currencies = [
          CurrencyModel(id: "1", name: "Pakistani Rupee", code: "PKR", symbol: "Rs."),
          CurrencyModel(id: "1", name: "US Dollar", code: "USD", symbol: "\$"),
          CurrencyModel(id: "1", name: "Canadian Dollar", code: "CAD", symbol: "CA\$"),
          CurrencyModel(id: "1", name: "Omani Riyal", code: "OMR", symbol: "OMR"),
          // Add more currencies if needed
        ];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("List not available")),
        );
      });
    } else {
      setState(() {
        _currencies = result;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrencyList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currencies'),
      ),
      body: _currencies.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                color: ColorProperties.lightColor2,
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Supported Currencies', style: TextStyle(fontSize: 25)),
                ),
                
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: _currencies.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(                      
                      crossAxisCount: 2, 
                      childAspectRatio: 1.45,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final currency = _currencies[index];
                      return Container(
                        decoration: BoxDecoration(  
                          gradient: ColorProperties.mainColorCross,
                          border: Border.all(color: Colors.black,width: 2),
                          borderRadius: BorderRadius.circular(15),
                          
                        ),
                        child: Card(
                          margin: EdgeInsets.zero,
                          color: Colors.transparent,
                          elevation: 10,
                          child: GridTile(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Currency Name",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                                    ),
                                    Text(
                                      currency.name,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white),
                                    ),
                                    const Text(
                                      "Currency Code",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                                    ),
                                     Text(
                                      currency.code,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white),
                                    ),
                                    const Text(
                                      "Currency Symbol",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                                    ),
                                    Text(
                                      currency.symbol,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
