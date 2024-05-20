import 'package:currensee/api_tasks.dart'; // Importing API tasks
import 'package:currensee/google_auth_service.dart'; // Importing Google authentication service
import 'package:currensee/preferences.dart'; // Importing preferences for user data
import 'package:currensee/screens/forgotPassword.dart'; // Importing forgot password screen
import 'package:currensee/screens/home.dart'; // Importing home screen
import 'package:currensee/screens/navigation.dart'; // Importing navigation screen
import 'package:currensee/screens/register.dart'; // Importing register screen
import 'package:firebase_auth/firebase_auth.dart'; // Importing Firebase Auth
import 'package:flutter/material.dart'; // Importing Flutter material package
import 'package:google_fonts/google_fonts.dart'; // Importing Google Fonts
import 'package:currensee/app_properties.dart'; // Importing app properties for styling
import 'package:google_sign_in/google_sign_in.dart'; // Importing Google Sign-In

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({super.key});

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState(); // Creating state for LoginPageScreen
}

class _LoginPageScreenState extends State<LoginPageScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Key for the form
  final TextEditingController _emailController = TextEditingController(); // Controller for email input
  final TextEditingController _passwordController = TextEditingController(); // Controller for password input
  bool isPasswordObs = true; // Variable to toggle password visibility

  String loginError = ""; // Variable to store login error message
  Icon icon = Icon(Icons.visibility, color: Colors.grey); // Icon for password visibility toggle

  // Function to show/hide password
  void showPass() {
    setState(() {
      isPasswordObs = !isPasswordObs;
      if (isPasswordObs) {
        icon = Icon(Icons.visibility, color: Colors.grey); // Show password
      } else {
        icon = Icon(Icons.visibility_off, color: Colors.grey); // Hide password
      }
    });
  }

  final AuthService _authService = AuthService(); // Instance of AuthService

  // Function to sign in with Google
  void _signInWithGoogle() async {
    User? user = await _authService.signInWithGoogle();
    if (user != null) {
      await setuser(user.uid); // Set user data in preferences
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => bottomNavigationBar()), // Navigate to bottomNavigationBar
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-in failed')), // Show error message
      );
    }
  }

  // Function to handle login
  Future<void> login() async {
    if (_formKey.currentState!.validate()) { // Validate form
      var res = await loginTask(_emailController.text, _passwordController.text); // Perform login task
      var res2 = res.keys.toList();
      print(res[res2[0]]);

      if (res[res2[0]]!) { // If login is successful
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => bottomNavigationBar())); // Navigate to bottomNavigationBar
      } else {
        setState(() {
          loginError = res2[0]; // Set login error message
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
            gradient: ColorProperties.blueGreenColor, // Applying gradient background
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
                      fontWeight: FontWeight.w900), // Styling text
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
                      topLeft: Radius.circular(40), // Top left corner radius
                      topRight: Radius.circular(40), // Top right corner radius
                    ),
                    color: Colors.white, // Background color
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                    child: Form(
                      key: _formKey, // Form key
                      child: Column(children: [
                        TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required for login'; // Email validation
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorProperties.darkColor,
                                    width: 2)), // Underline border styling
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorProperties.darkColor, // Label text color
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
                              return 'Please insert a password'; // Password validation
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorProperties.darkColor,
                                    width: 2)), // Underline border styling
                            suffixIcon: IconButton(
                              onPressed: showPass, // Toggle password visibility
                              icon: icon, // Password visibility icon
                            ),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorProperties.darkColor, // Label text color
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
                            gradient: ColorProperties.mainColor, // Applying gradient background
                            borderRadius: BorderRadius.circular(30), // Optional: Set border radius
                          ),
                          child: Material(
                            color: Colors.transparent, // Set the material color to transparent
                            child: InkWell(
                              borderRadius: BorderRadius.circular(30), // Optional: Set border radius
                              onTap: login, // Handle login on tap
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
                                        ForgotPasswordScreen(), // Navigation to ForgotPasswordScreen
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
                                height: 16), // Add space between the two text widgets
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
                                              const RegisterPageScreen())); // Navigation to RegisterPageScreen
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
                          onPressed: _signInWithGoogle, // Sign in with Google
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            backgroundColor: Colors.white, // Button background color
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
