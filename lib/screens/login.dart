
import 'package:currensee/ApiTasks.dart';
import 'package:currensee/screens/forgotPassword.dart';
import 'package:currensee/screens/home.dart';
import 'package:currensee/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:currensee/app_properties.dart';

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({super.key});

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isPasswordObs=true;

  String loginError="";

  void showPass(){
    setState(() {
      isPasswordObs= !isPasswordObs;
      // if(isPasswordObs){
      //   icon=Icon(Icons.remove_red_eye_outlined);
      // } else{
      //   icon=FaIcon(FontAwesomeIcons.gamepad);
      // }
    });
  }

  Future<void> login() async{
    var res = await loginTask(_emailController.text, _passwordController.text);
    var res2=res.keys.toList();
    if(res[res2[0]]!){
      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => HomeScreen()));
    } else{
      setState(() {
        loginError=res2[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: colorProperties.gradientcolor,
              ),
              child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(children: [
                        Column(
                          children: [
                            Text(
                              "Welcome Back",
                              style: GoogleFonts.concertOne(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 47,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                                height:
                                    15), // Add space between the two text widgets
                            Text(
                              "Enter Your Credentials to Login",
                              style: GoogleFonts.badScript(
                                textStyle: TextStyle(
                                  color: Colors.amberAccent,
                                  fontSize: 25,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Form(
                            key: _formKey,
                            child: Column(children: [
                              TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white70,
                                  prefixIcon: Icon(Icons.email_rounded,
                                      color: Colors.black),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  labelText: "Enter Your Email",
                                  labelStyle: TextStyle(
                                    color: Color(0x77000000), // Label ka color
                                    fontSize: 19,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 25),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              TextFormField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white70,
                                  prefixIcon: Icon(Icons.key_rounded,
                                      color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  labelText: "Enter Your Password",
                                  labelStyle: TextStyle(
                                    color: Color(0x77000000), // Label ka color
                                    fontSize: 19,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 25),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 50),
                                ),
                                child: Text(
                                  'LOGIN',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.bold,
                                    height: 0,
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
                                          color: Colors.orange,
                                          fontSize: 22,
                                          fontStyle: FontStyle.italic,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors
                                              .purple, // Change the underline color
                                          decorationStyle:
                                              TextDecorationStyle.dashed,
                                          decorationThickness: 3),
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          16), // Add space between the two text widgets
                                  Text(
                                    "Don't Have an Account?",
                                    style: TextStyle(
                                        color: Colors.amberAccent,
                                        fontSize: 22,
                                        fontStyle: FontStyle.italic,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors
                                            .purple, // Change the underline color
                                        decorationStyle:
                                            TextDecorationStyle.dashed,
                                        decorationThickness: 3),
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
                                            color: Color(0xFFFFFFFF),
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
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton.icon(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    side: BorderSide(color: Colors.black),
                                  ),
                                ),
                                icon: Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Image.asset(
                                    'lib/images/Google_logo.png', // Replace this with your Google logo asset path
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
                                    height: 0,
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        )
                      ])))),
        )
    );
  }
}