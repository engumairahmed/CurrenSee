import 'package:currensee/screens/FeedBack.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FAQScreen extends StatefulWidget {
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final List<Map<String, String>> faqs = [
    {
      'question': 'How do I convert currencies using CurrenSee app?',
      'answer':
      'CurrenSee app allows you to convert currencies easily. Simply select your base currency, choose the target currency, enter the amount, and the app will calculate the converted amount for you.',
    },
    {
      'question': 'Are the exchange rates in CurrenSee real-time?',
      'answer':
      'Yes, CurrenSee fetches real-time exchange rates from reliable sources to ensure accuracy.',
    },
    {
      'question': 'Can I use CurrenSee app offline?',
      'answer':
      'CurrenSee app requires an internet connection to fetch real-time exchange rates.',
    },
    {
      'question':
      'Can I view historical exchange rate data?',
      'answer':
      'Yes, you can view historical exchange rate data in CurrenSee. The app provides trend charts and analysis for your reference.',
    },
    {
      'question': 'How do I set rate alerts?',
      'answer':
      'You can set rate alerts for specific currency pairs in CurrenSee. Once the exchange rate reaches your specified threshold, you will receive a notification.',
    },
    {
      'question':
      'How can I access the list of supported currencies?',
      'answer':
      'CurrenSee provides a searchable and filterable list of supported currencies. You can easily find and select the currencies you need.',
    },
    {
      'question':
      'How do I contact customer support for assistance?',
      'answer':
      'If you need any assistance or have inquiries, you can contact our customer support team directly through the app. Simply navigate to the Help Center section and choose the contact option.',
    },
    {
      'question': 'Is there a limit on the amount I can convert?',
      'answer':
      'There is no specific limit on the amount you can convert.',
    },
    {
      'question': 'Is there a fee for using CurrenSee?',
      'answer':
      'CurrenSee is free to use for all users. We do not charge any fees for currency conversion or accessing exchange rate information.',
    },
    {
      'question':
      'How do I provide feedback or report issues?',
      'answer':
      'Your feedback is valuable to us! You can easily provide feedback or report any issues through the app. Simply navigate to the Feedback section and share your thoughts with us. We appreciate your input!',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQ's Screen"),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 225, 88, 181),
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 250, 130, 130),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Frequently Asked Questions',
                  style: GoogleFonts.concertOne(
                    textStyle: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: faqs.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ExpansionTile(
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            faqs[index]['question'] ?? '',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              faqs[index]['answer'] ?? '',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: (){
          Navigator.push(
            context, MaterialPageRoute(builder: (context)=> FeedBackScreen()),
          );
        },

        child: BottomAppBar(
          color: Colors.pinkAccent,
          height: 60,
          child: Center(
              child: Text("Feedback", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25, fontStyle: FontStyle.italic),)),
        ),
      ),
    );
  }
}
