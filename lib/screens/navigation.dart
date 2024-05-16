
import 'package:currensee/app_properties.dart';
import 'package:currensee/preferences.dart';
import 'package:currensee/screens/converter.dart';
import 'package:currensee/screens/currency_converter.dart';
import 'package:currensee/screens/faq_screen.dart';
import 'package:currensee/screens/feedback.dart';
import 'package:currensee/screens/chart.dart';
import 'package:currensee/screens/home.dart';
import 'package:flutter/material.dart';

class bottomNavigationBar extends StatefulWidget {
  const bottomNavigationBar({super.key});

  @override
  State<bottomNavigationBar> createState() => _bottomNavigationBarState();
}

class _bottomNavigationBarState extends State<bottomNavigationBar> {

  String userName="";
  String userEmail="";

  Future<void> showUserProfile() async {
    var user = await getUserData();
    var id = await getUser();
    print(id);
    print(user.name);
    print(user.email);
    setState(() { 
    userName=user.name;
    userEmail=user.email;
    });
  }

  int myCurrentIndex = 1 ;
  List pages = const[
    HomeScreen(),
    ChartScreen(),
    CurrencyConverterScreen(),
    FeedBackScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
         appBar: AppBar(
        title: Text(
          "App currency Home",
          style: TextStyle(color: Color.fromARGB(255, 95, 0, 107)),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      drawer: Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
            gradient: ColorProperties.mainColor,
          ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                CircleAvatar(
                  radius: 40.0,
                  backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLHS121TqtsuRK7rS3D9U0qY4EhvhUhNwKrD8_zq9QUg&s"),
                ),
                SizedBox(height: 5.0,),
                Text(userName,
                  style: TextStyle(fontSize: 22.0, color: Colors.white),
                ),
                Text(userEmail,
                  style: TextStyle(fontSize: 22.0, color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
          Divider(
            color: Colors.grey,
            thickness: 2.0,
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Historical Rates'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChartScreen()),
              );
            },
          ),
          Divider(
            color: Colors.grey,
            thickness: 2.0,
          ),
          ListTile(
            leading: Icon(Icons.currency_exchange),
            title: Text('Converter'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConverterScreen()),
              );
            },
          ),
          Divider(
            color: Colors.grey,
            thickness: 2.0,
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('FeedBack'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FeedBackScreen()),
              );
            },
          ),
          Divider(
            color: Colors.grey,
            thickness: 2.0,
          ),
          ListTile(
            leading: Icon(Icons.question_answer),
            title: Text('Faq'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FAQScreen()),
              );
            },
          ),
        ],
      ),
    ),
      backgroundColor: Colors.purple,
bottomNavigationBar: Container(
  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
  decoration: BoxDecoration(boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.3),
    )
  ]),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.purple,
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
        BottomNavigationBarItem(icon: Icon(Icons.feedback), label: "Feedback"),
        // BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
      ],),
    ),
    ),
    body: pages[myCurrentIndex],
  );
  }
}