import 'package:currensee/app_properties.dart'; // Importing app properties for styling
import 'package:currensee/screens/AppBar.dart'; // Importing custom app bar
import 'package:currensee/screens/FeedBack.dart'; // Importing feedback screen (not used in the code)
import 'package:currensee/screens/drawer.dart'; // Importing custom drawer

import 'package:flutter/material.dart'; // Importing Flutter material package
import 'package:google_fonts/google_fonts.dart'; // Importing Google Fonts package

class FAQScreen extends StatefulWidget {
  @override
  _FAQScreenState createState() => _FAQScreenState(); // Creating state for FAQScreen
}

class _FAQScreenState extends State<FAQScreen> {
  final List<Map<String, String>> faqs = [
    {
      'question': 'How do I convert currencies using CurrenSee app?',
      'answer':
          'CurrenSee app allows you to convert currencies easily. Simply select your base currency, choose the target currency, enter the amount, and the app will calculate the converted amount for you.',
      'expanded': 'false',
    },
    {
      'question': 'Are the exchange rates in CurrenSee real-time?',
      'answer':
          'Yes, CurrenSee fetches real-time exchange rates from reliable sources to ensure accuracy.',
      'expanded': 'false',
    },
    {
      'question': 'Can I use CurrenSee app offline?',
      'answer': 'CurrenSee app requires an internet connection to fetch real-time exchange rates.',
      'expanded': 'false',
    },
    {
      'question': 'Can I view historical exchange rate data?',
      'answer':
          'Yes, you can view historical exchange rate data in CurrenSee. The app provides trend charts and analysis for your reference.',
      'expanded': 'false',
    },
    {
      'question': 'How do I set rate alerts?',
      'answer':
          'You can set rate alerts for specific currency pairs in CurrenSee. Once the exchange rate reaches your specified threshold, you will receive a notification.',
      'expanded': 'false',
    },
    {
      'question': 'How can I access the list of supported currencies?',
      'answer':
          'CurrenSee provides a searchable and filterable list of supported currencies. You can easily find and select the currencies you need.',
      'expanded': 'false',
    },
    {
      'question': 'How do I contact customer support for assistance?',
      'answer':
          'If you need any assistance or have inquiries, you can contact our customer support team directly through the app. Simply navigate to the Help Center section and choose the contact option.',
      'expanded': 'false',
    },
    {
      'question': 'Is there a limit on the amount I can convert?',
      'answer': 'There is no specific limit on the amount you can convert.',
      'expanded': 'false',
    },
    {
      'question': 'Is there a fee for using CurrenSee?',
      'answer':
          'CurrenSee is free to use for all users. We do not charge any fees for currency conversion or accessing exchange rate information.',
      'expanded': 'false',
    },
    {
      'question': 'How do I provide feedback or report issues?',
      'answer':
          'Your feedback is valuable to us! You can easily provide feedback or report any issues through the app. Simply navigate to the Feedback section and share your thoughts with us. We appreciate your input!',
      'expanded': 'false',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Feedback Screen"),
      // ),
      appBar: RoundAppBar(pageTitle: 'FAQs'), // Custom app bar with title 'FAQs'
      drawer: CustomDrawer(), // Custom navigation drawer
      body: Container(
        height: MediaQuery.of(context).size.height, // Full screen height
        decoration: BoxDecoration(
          gradient: ColorProperties.mainColor, // Applying gradient background
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0), // Padding around the entire column
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align items to the start (left)
              children: [
                Text(
                  'Frequently Asked Questions',
                  style: GoogleFonts.badScript(
                    textStyle: TextStyle(
                      fontSize: 36, // Text size
                      fontWeight: FontWeight.bold, // Text weight
                      color: Colors.white, // Text color
                    ),
                  ),
                ),
                SizedBox(height: 20), // Spacer
                Card(
                  elevation: 5, // Card elevation for shadow effect
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5), // Rounded corners
                  ),
                  child: ListView.builder(
                    shrinkWrap: true, // Prevent ListView from expanding infinitely
                    itemCount: faqs.length, // Number of FAQ items
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                        title: Text(
                          faqs[index]['question'] ?? '', // FAQ question text
                          style: TextStyle(
                            fontSize: 18, // Text size
                            fontWeight: FontWeight.bold, // Text weight
                            color: Color.fromARGB(255, 4, 63, 112), // Text color
                          ),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0), // Padding around the answer text
                            child: Text(
                              faqs[index]['answer'] ?? '', // FAQ answer text
                              style: TextStyle(
                                fontSize: 16, // Text size
                                color: Colors.black, // Text color
                              ),
                            ),
                          ),
                        ],
                        initiallyExpanded: faqs[index]['expanded'] == 'true', // Check if the FAQ should be expanded initially
                        onExpansionChanged: (value) {
                          setState(() {
                            faqs[index]['expanded'] = value ? 'true' : 'false'; // Update the expanded state
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}