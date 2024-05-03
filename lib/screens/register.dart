import 'package:currensee/ApiTasks.dart';
import 'package:currensee/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:currensee/app_properties.dart';

class RegisterPageScreen extends StatefulWidget {
  const RegisterPageScreen({Key? key}) : super(key: key);

  @override
  State<RegisterPageScreen> createState() => _RegisterPageScreenState();
}

class _RegisterPageScreenState extends State<RegisterPageScreen> {
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String _password = '';
  String _confirmPassword = '';
  String emailError = '';

  Future<void> register() async{
    if(_formKey.currentState!.validate()) {
      var res = await registerTask(_nameController.text, _emailController.text,
          _passwordController.text);
      var res2=res.keys.toList();
      print(res);
      if (res[res2[0]]!) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPageScreen()));
      } else {
        setState(() {
          emailError = res2[0];
        });
      }
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
              child: Column(
                children: [
                  Column(
                    children: [
                      Text("Create Account", style: GoogleFonts.concertOne(
                        textStyle: TextStyle(color: Colors.white, fontSize: 47, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                      ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor:  Colors.white70,
                              prefixIcon: Icon(Icons.person, color: Colors.black),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                              ),
                              labelText: "Enter Your Name",
                              labelStyle: TextStyle(
                                color: Color(0x77000000), // Label ka color
                                fontSize: 19,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor:  Colors.white70,
                              prefixIcon: Icon(Icons.email_rounded, color: Colors.black),
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
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            onChanged: (value) {
                                      setState(() {
                                        _password = value;
                                      });
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a password';
                                      }
                                      return null;
                                    },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor:  Colors.white70,
                              prefixIcon: Icon(Icons.key_rounded, color: Colors.black),
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
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            controller: _confirmPasswordController,
                            onChanged: (value) {
                                  setState(() {
                                    _confirmPassword = value;
                                  });
                              },
                            validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please confirm your password';
                                  }
                                  if (value != _password) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                              },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor:  Colors.white70,
                              prefixIcon: Icon(Icons.lock, color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                              ),
                              labelText: "Confirm Your Password",
                              labelStyle: TextStyle(
                                color: Color(0x77000000), // Label ka color
                                fontSize: 19,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                            ),
                          ),
                                  const SizedBox(
                        height: 25,
                           ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      String name = _nameController.text;
                      String email = _emailController.text;
                      String password = _passwordController.text;
                      String confirmPassword = _confirmPasswordController.text;
        
                      // Use the values as needed
                      print('Name: $name');
                      print('Email: $email');
                      print('Password: $password');
                      print('Confirm Password: $confirmPassword');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                    ),
                    child: Text(
                      'REGISTER',
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
                    height: 15,
                  ),
                  Column(
                    children: [
                      // Add space between the two text widgets
                      Text(
                        "Already have an Account",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              color: Colors.amberAccent,
                              fontSize: 24,
                              fontStyle: FontStyle.italic,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.purple, // Change the underline color
                              decorationStyle: TextDecorationStyle.dashed,
                              decorationThickness: 3
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPageScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}