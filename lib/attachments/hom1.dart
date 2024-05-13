
import 'package:currensee/attachments/Converter.dart';
import 'package:currensee/attachments/rates_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<RatesModel> ratesModel;
  late Future<Map> currenciesModel;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    // ratesModel = fetchRates();
    // currenciesModel = fetchCurrencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const Icon(Icons.currency_exchange),
        title: const Text('Currency Convertor'),
      ),
      body: FutureBuilder<RatesModel>(
        future: ratesModel,
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          } else {
            return FutureBuilder<Map>(
                future: currenciesModel,
                builder: (context, index){
                  if (index.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(),);
                  } else if (index.hasError) {
                    return Center(child: Text('Error: ${index.error}'));
                  } else {
                    return CurrencyConverter(
                      rates: snapshot.data!.rates,
                      currencies: index.data!,
                    );
                  }
                }
            );
          }
        }
      ),
    );
  }
  
 


// class AppCurrencyHome extends StatefulWidget {
//   const AppCurrencyHome({Key? key}) : super(key: key);


//   @override
//   State<AppCurrencyHome> createState() => _AppCurrencyHomeState();
// }


// class _AppCurrencyHomeState extends State<AppCurrencyHome> {
//   final List<String> cardTitles = ['Currency converter', 'Card 2', 'Card 3'];

//   @override
//   Widget build(BuildContext context) {
//      return Scaffold(
//       appBar: AppBar(
//         title: Text('Card List'),
//       ),
//       body: ListView.builder(
//         itemCount: cardTitles.length,
//         itemBuilder: (BuildContext context, int index) {
//           return ListTile(
//             title: Text(cardTitles[index]),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => DetailPage(cardTitle: cardTitles[index]),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class DetailPage extends StatelessWidget {
//   final String cardTitle;

//   DetailPage({required this.cardTitle});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(cardTitle),
//       ),
//       body: Center(
//         child: Text('Details of $cardTitle'),
//       ),
//     );
//   }
// }

}