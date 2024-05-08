import 'package:currency_app/FaqScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({Key? key}) : super(key: key);

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  int _rating = 0;
  String _feedback = '';
  late String _timestamp;

  @override
  void initState() {
    super.initState();
    _timestamp = _getCurrentTimestamp();
  }

  String _getCurrentTimestamp() {
    var now = DateTime.now();
    return DateFormat('dd-MM-yyyy /  hh:mm').format(now);
  }

  void _onRatingChanged(int rating) {
    setState(() {
      _rating = rating;
    });
  }

  void _onFeedbackChanged(String value) {
    setState(() {
      _feedback = value;
    });
  }

  void _submitFeedback() {
    if (formkey.currentState!.validate()) {
      // Send feedback data to your server or database
      print('Rating: $_rating');
      print('Feedback: $_feedback');
      print('Timestamp: $_timestamp');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Feedback Form',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 250, 130, 130),
            Color.fromARGB(255, 255, 255, 255),
          ]),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Rate our CurrenSee app:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => _onRatingChanged(1),
                    icon: Icon(_rating >= 1 ? Icons.star : Icons.star_border),
                    color: Colors.orange,
                    iconSize: 50.0,
                  ),
                  IconButton(
                    onPressed: () => _onRatingChanged(2),
                    icon: Icon(_rating >= 2 ? Icons.star : Icons.star_border),
                    color: Colors.orange,
                    iconSize: 50.0,
                  ),
                  IconButton(
                    onPressed: () => _onRatingChanged(3),
                    icon: Icon(_rating >= 3 ? Icons.star : Icons.star_border),
                    color: Colors.orange,
                    iconSize: 50.0,
                  ),
                  IconButton(
                    onPressed: () => _onRatingChanged(4),
                    icon: Icon(_rating >= 4 ? Icons.star : Icons.star_border),
                    color: Colors.orange,
                    iconSize: 50.0,
                  ),
                  IconButton(
                    onPressed: () => _onRatingChanged(5),
                    icon: Icon(_rating >= 5 ? Icons.star : Icons.star_border),
                    color: Colors.orange,
                    iconSize: 50.0,
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                'Do You Have Any Thoughts You Would Like to Share?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'We would love to hear your feedback',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 6,
                        onChanged: _onFeedbackChanged,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        '$_timestamp',
                        style: TextStyle(fontSize: 16.0),
                     

                      ),
                      SizedBox(height: 16.0),
                      TextButton(
                        onPressed: _submitFeedback,
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              color: Color(0xB2000000),
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FAQScreen()),
          );
        },
        child: BottomAppBar(
          color: Colors.pinkAccent,
          height: 60,
          child: Center(
              child: Text(
            "FAQ ",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                fontStyle: FontStyle.italic),
          )),
        ),
      ),
    );
  }
}
