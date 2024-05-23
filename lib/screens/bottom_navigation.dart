
import 'package:currensee/api_tasks.dart';
import 'package:currensee/google_auth_service.dart';
import 'package:currensee/preferences.dart';
import 'package:currensee/screens/conversion/currency_converter.dart';
import 'package:currensee/screens/drawer.dart';
import 'package:currensee/screens/conversion/chart.dart';
import 'package:currensee/screens/auth/login.dart';
import 'package:currensee/screens/home.dart';
import 'package:flutter/material.dart';

class bottomNavigationBar extends StatefulWidget {
  const bottomNavigationBar({super.key});

  @override
  State<bottomNavigationBar> createState() => _bottomNavigationBarState();
}

class _bottomNavigationBarState extends State<bottomNavigationBar> {

  AuthService _authService = new AuthService();


  int myCurrentIndex = 2 ;
  List pages = const[
    HomeScreen(),
    ChartScreen(),
    CurrencyConverterScreen()
  ];

    Future<void> _fetchCurrencyCodes() async {

    List<String> _currencyCodes = [];

    try {

      _currencyCodes = await fetchCurrencyCodes();

        await setCurrencyCodes(_currencyCodes);
        print('SetCurrency Tried');  

    } catch (e) {

      print("Below is an error");
      print(e.toString());

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchCurrencyCodes();
    print('BNB Launched');
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      drawer: CustomDrawer(),
      backgroundColor: Colors.white,
bottomNavigationBar: Container(
  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  child: ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(50)),
    child: BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Color.fromARGB(255, 98, 158, 140),
      unselectedItemColor: Colors.black,
      currentIndex: myCurrentIndex,
      onTap: (index){
        setState(() {
          myCurrentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart_sharp), label: "Chart"),
        BottomNavigationBarItem(icon: Icon(Icons.currency_exchange), label: "Convert"),
      ],),
    ),
    ),
    body: pages[myCurrentIndex],
  );
  }

void showCustomDialogue({required String id}){
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Are you sure you want to sign out of this application?"),
          actions: [
            TextButton(onPressed: () {
              _authService.signOut().then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPageScreen())));
            }, child: Text("Logout",style: TextStyle(color: Colors.red),)),
            TextButton(onPressed: () {
              Navigator.of(context).pop();
            }, child: Text("Cancel",style: TextStyle(color: Colors.black)))
          ],
        );
      },
      );
  }

}