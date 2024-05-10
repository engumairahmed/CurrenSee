import 'package:currensee/ApiTasks.dart';
import 'package:currensee/app_properties.dart';
import 'package:currensee/navigation.dart';
import 'package:currensee/screens/FaqScreen.dart';
import 'package:flutter/material.dart';

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({Key? key}) : super(key: key);

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  int _rating = 0;
  String _feedback = '';

  @override
  void initState() {
    super.initState();
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

  Future<void> _submitFeedback() async {
    if (formkey.currentState!.validate()) {
      // Send feedback data to your server or database
      var res = await feedbackTask(_feedback, _rating);
      print('Rating: $_rating');
      print('Feedback: $_feedback');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: ColorProperties.gradi,
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 60, 10, 0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Rate our application:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Container(
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Colors.orange),
                    borderRadius: BorderRadius.circular(
                        10),
                  color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => _onRatingChanged(1),
                        icon:
                            Icon(_rating >= 1 ? Icons.star : Icons.star_border),
                        color: Colors.orange,
                        iconSize: 50.0,
                      ),
                      IconButton(
                        onPressed: () => _onRatingChanged(2),
                        icon:
                            Icon(_rating >= 2 ? Icons.star : Icons.star_border),
                        color: Colors.orange,
                        iconSize: 50.0,
                      ),
                      IconButton(
                        onPressed: () => _onRatingChanged(3),
                        icon:
                            Icon(_rating >= 3 ? Icons.star : Icons.star_border),
                        color: Colors.orange,
                        iconSize: 50.0,
                      ),
                      IconButton(
                        onPressed: () => _onRatingChanged(4),
                        icon:
                            Icon(_rating >= 4 ? Icons.star : Icons.star_border),
                        color: Colors.orange,
                        iconSize: 50.0,
                      ),
                      IconButton(
                        onPressed: () => _onRatingChanged(5),
                        icon:
                            Icon(_rating >= 5 ? Icons.star : Icons.star_border),
                        color: Colors.orange,
                        iconSize: 50.0,
                      ),
                    ],
                  ),
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
                        ElevatedButton(
                          onPressed: _submitFeedback,
                          style: ElevatedButton.styleFrom(
                            elevation: 15,
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 50),
                          ),
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                color: Color(0xB2000000),
                                fontSize: 30,
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
      ),
    );
  }
}
