import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 118, 51, 170),
                  Color.fromARGB(255, 215, 15, 233),
                ],
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 40.0, left: 22),
              child: Text(
                'Welcome To Login!',
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: AutofillHints.birthday,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: Form(
                  // Add a Form widget to enable form validation
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.check, color: Colors.grey),
                          labelText: 'Gmail', // Use labelText instead of label
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 118, 51, 170),
                          ),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          suffixIcon:
                              Icon(Icons.visibility_off, color: Colors.grey),
                          labelText: 'Password', // Use labelText instead of label
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 118, 51, 170),
                          ),
                        ),
                      ),
                      SizedBox(height: 60),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                            color: Color.fromARGB(255, 118, 51, 170),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        height: 55,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 118, 51, 170),
                              Color.fromARGB(255, 215, 15, 233),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'LOG IN',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 80),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              'Dont have an account?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 118, 51, 170),
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              'Sign up',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Color.fromARGB(255, 215, 15, 233),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
