import 'package:currensee/app_properties.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  Future<void> resetLink() async{
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      _formKey.currentState!.save();
      String email = _emailController.text.trim();
      if (email.isNotEmpty) {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: email,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "We have sent you an email to reset your password",
              style: GoogleFonts.badScript(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w900),
              ),
            ),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: ColorProperties.blueGreenColor,
          ),
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Column(children: [
              Text(
                "Forgot you password.???",
                style: GoogleFonts.badScript(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w900),
                ),
              ),
              SizedBox(height: 10),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Container(
                  height: MediaQuery.sizeOf(context).height,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                    child: Form(
                      key: _formKey,
                      child: Column(children: [
                        TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Pleas provide email address';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorProperties.darkColor,
                                    width: 2)),
                            labelText: 'Enter you Email Address for password reset link',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorProperties.darkColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 200, // Adjust the width as needed
                          height: 50, // Adjust the height as needed
                          decoration: BoxDecoration(
                            gradient: ColorProperties.mainColor,
                            borderRadius: BorderRadius.circular(
                                30), // Optional: Set border radius
                          ),
                          child: Material(
                            color: Colors
                                .transparent, // Set the material color to transparent
                            child: InkWell(
                              borderRadius: BorderRadius.circular(
                                  30), // Optional: Set border radius
                              onTap: resetLink,
                              child: Center(
                                child: Text(
                                  'RESET',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white, // Set text color
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        
                        const SizedBox(
                          height: 10,
                        ),
                      ]),
                    ),
                  ),
                ),
              )
            ]),
          ))),
    ));
  }
}