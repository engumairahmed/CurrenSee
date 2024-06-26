import 'package:currensee/api_tasks.dart'; // Importing API tasks
import 'package:currensee/google_auth_service.dart'; // Importing Google authentication service
import 'package:currensee/preferences.dart'; // Importing preferences for user data
import 'package:currensee/screens/bottom_navigation.dart'; // Importing navigation screen
import 'package:currensee/screens/auth/forgotPassword.dart'; // Importing forgot password screen
import 'package:currensee/screens/auth/register.dart'; // Importing register screen
import 'package:firebase_auth/firebase_auth.dart'; // Importing Firebase Auth
import 'package:flutter/material.dart'; // Importing Flutter material package
import 'package:google_fonts/google_fonts.dart'; // Importing Google Fonts
import 'package:currensee/app_properties.dart'; // Importing app properties for styling

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({super.key});

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logOut();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isPasswordObs = true;

  String loginError = "";
  Icon icon = Icon(Icons.visibility, color: Colors.grey);

  AuthService _authService = AuthService();

// Function to sign out the user
  Future<void> logOut() async {
    await _authService.signOut();
  }

// Function to show/hide password
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

// Function to sign in with Google
  void _signInWithGoogle() async {
    User? user =
        await _authService.signInWithGoogle(); // Perform Google sign-in

    if (user != null) {
      await setuser(user.uid); // Save user ID to preferences

      // Navigate to bottomNavigationBar screen if sign-in is successful
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => bottomNavigationBar()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-in failed')),
      );
    }
  }

// Function to log in using email and password
  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      // Perform login task with email and password
      String capitalizedEmail = _emailController.text.toUpperCase();
      var res =
          await loginTask(capitalizedEmail, _passwordController.text);
      var res2 = res.keys.toList();

      if (res[res2[0]]!) {
        // Check if login was successful
        // Navigate to bottomNavigationBar screen if login is successful
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => bottomNavigationBar()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign-in failed')),
        );
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
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
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: ColorProperties.mainColor,
                            borderRadius: BorderRadius.circular(30), //
                          ),
                          child: Material(
                            color: Colors
                                .transparent, // Set the material color to transparent
                            child: InkWell(
                              borderRadius: BorderRadius.circular(30), //
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
                                        ForgotPasswordScreen(), // navigate to forgot password screen
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
                            SizedBox(height: 16),
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
                                  "SIGN UP",
                                  style: TextStyle(
                                      color: ColorProperties.darkColor,
                                      decoration: TextDecoration.underline,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 25,),
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
                              height: 40,
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
