
import 'package:currensee/app_properties.dart';
import 'package:currensee/google_auth_service.dart';
import 'package:currensee/preferences.dart';
import 'package:currensee/screens/converter.dart';
import 'package:currensee/screens/currency_converter.dart';
import 'package:currensee/screens/drawer.dart';
import 'package:currensee/screens/faq_screen.dart';
import 'package:currensee/screens/feedback.dart';
import 'package:currensee/screens/chart.dart';
import 'package:currensee/screens/home.dart';
import 'package:currensee/screens/login.dart';
import 'package:flutter/material.dart';

class bottomNavigationBar extends StatefulWidget {
  const bottomNavigationBar({super.key});

  @override
  State<bottomNavigationBar> createState() => _bottomNavigationBarState();
}

class _bottomNavigationBarState extends State<bottomNavigationBar> {

  AuthService _authService = new AuthService();

  String userName="";
  String userEmail="";

  Future<void> showUserProfile() async {
    print('BNG showUser Execution');
    var user = await getUserData();
    var id = await getUser();
    setState(() { 
    userName=user.name;
    userEmail=user.email;
    print('BGN showUser Execution Ended');
    });
  }

  int myCurrentIndex = 2 ;
  List pages = const[
    HomeScreen(),
    ChartScreen(),
    CurrencyConverterScreen()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Bottom Naivgation Screen Launched');
    showUserProfile();
    print('BTN showUser Executed');
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      drawer: CustomDrawer(),
      backgroundColor: Colors.white,
bottomNavigationBar: Container(
  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: BottomNavigationBar(
      backgroundColor: Color(0xFFA2A2A1),
      selectedItemColor: ColorProperties.lightColor,
      unselectedItemColor: Colors.black,
      currentIndex: myCurrentIndex,
      onTap: (index){
        setState(() {
          myCurrentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.chat_rounded), label: "Chart"),
        BottomNavigationBarItem(icon: Icon(Icons.local_convenience_store_rounded), label: "Convert"),
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