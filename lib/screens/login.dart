import 'package:currensee/api_tasks.dart';
import 'package:currensee/google_auth_service.dart';
import 'package:currensee/preferences.dart';
import 'package:currensee/screens/forgotPassword.dart';
import 'package:currensee/screens/home.dart';
import 'package:currensee/screens/navigation.dart';
import 'package:currensee/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:currensee/app_properties.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({super.key});

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {

  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isPasswordObs = true;

  String loginError = "";
  Icon icon = Icon(Icons.visibility, color: Colors.grey);

  void showPass() {
    setState(() {
      isPasswordObs = !isPasswordObs;
      if (isPasswordObs) {
        icon = Icon(Icons.visibility, color: Colors.grey);
      } else {
        icon = Icon(Icons.visibility_off, color: Colors.grey);
      }
    });
  }

  final AuthService _authService = AuthService();

  void _signInWithGoogle() async {
    User? user = await _authService.signInWithGoogle();
    if (user != null) {
      await setuser(user.uid);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => bottomNavigationBar()), // Replace with your home screen
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-in failed')),
      );
    }
  }


  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      var res =
          await loginTask(_emailController.text, _passwordController.text);
      var res2 = res.keys.toList();
      print(res[res2[0]]);

      if (res[res2[0]]!) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => bottomNavigationBar()));
      } else {
        setState(() {
          loginError = res2[0];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: ColorProperties.mainColor,
          ),
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Column(children: [
              Text(
                "Welcome Back",
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
                              return 'Email is required for login';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorProperties.darkColor,
                                    width: 2)),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorProperties.darkColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          obscureText: isPasswordObs,
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please insert a password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorProperties.darkColor,
                                    width: 2)),
                            suffixIcon: IconButton(
                              onPressed: showPass,
                              icon: icon,
                            ),
                            labelText: 'Password',
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
                              onTap: login,
                              child: Center(
                                child: Text(
                                  'LOGIN',
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
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ForgotPasswordScreen(), // ForgotPasswordScreen par navigation
                                  ),
                                );
                              },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: ColorProperties.darkColor,
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    16), // Add space between the two text widgets
                            Text(
                              "Don't Have an Account?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterPageScreen()));
                                },
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(
                                      color: ColorProperties.darkColor,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '------------------or------------------',
                          style: TextStyle(
                            color: ColorProperties.darkColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton.icon(
                          onPressed: _signInWithGoogle,
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 50),
                          ),
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Image.asset(
                              'lib/images/Google_logo.png',
                              height: 40, // Adjust the height as needed
                            ),
                          ),
                          label: Text(
                            'Login With Google',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontStyle: FontStyle.normal,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
