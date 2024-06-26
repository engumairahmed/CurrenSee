import 'package:currensee/api_tasks.dart';
import 'package:currensee/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:currensee/app_properties.dart';

class RegisterPageScreen extends StatefulWidget {
  const RegisterPageScreen({Key? key}) : super(key: key);

  @override
  State<RegisterPageScreen> createState() => _RegisterPageScreenState();
}

class _RegisterPageScreenState extends State<RegisterPageScreen> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Key for the form
  final TextEditingController _nameController =
      TextEditingController(); // Controller for name input
  final TextEditingController _emailController =
      TextEditingController(); // Controller for email input
  final TextEditingController _passwordController =
      TextEditingController(); // Controller for password input
  final TextEditingController _confirmPasswordController =
      TextEditingController(); // Controller for confirm password input

  String _password = ''; // Variable to store password
  String emailError = ''; // Variable to store email error message

  bool isPasswordObs = true; // Variable to toggle password visibility

  Icon icon = Icon(Icons.visibility,
      color: Colors.grey); // Icon for password visibility toggle

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

  // Function to handle registration
  Future<void> register() async {
    if (_formKey.currentState!.validate()) {
      String capitalizedEmail = _emailController.text.toUpperCase();
      var res = await registerTask(_nameController.text, capitalizedEmail,
          _passwordController.text, 'null'); // Perform registration task
      var res2 = res.keys.toList();

      if (res[res2[0]]!) {
        // If registration is successful

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(res2[0])), // Show success message
        );

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const LoginPageScreen())); // Navigate to LoginPageScreen
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(res2[0])), // Show error message
        );

        setState(() {
          emailError = res2[0]; // Set email error message
        });
      }
    }
  }

  @override
  void dispose() {
    // Dispose controllers to free up resources
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
          height: MediaQuery.of(context)
              .size
              .height, // Get the height of the screen
          decoration: BoxDecoration(
            gradient: ColorProperties.mainColor, // Applying gradient background
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(height: 50), // Spacer
                    Text(
                      "Create Account",
                      style: GoogleFonts.badScript(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 47,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold), // Styling text
                      ),
                    ),
                    SizedBox(height: 20), // Spacer
                  ],
                ),
                const SizedBox(height: 20), // Spacer
                Container(
                  height: MediaQuery.sizeOf(context)
                      .height, // Get the height of the screen
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40), // Top left corner radius
                      topRight: Radius.circular(40), // Top right corner radius
                    ),
                    color: Colors.white, // Background color
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(40), // Padding
                    child: Column(
                      children: [
                        Form(
                          key: _formKey, // Form key
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorProperties.darkColor,
                                          width:
                                              2)), // Underline border styling
                                  labelText: 'Name',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorProperties
                                        .darkColor, // Label text color
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25), // Spacer
                              TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorProperties.darkColor,
                                          width:
                                              2)), // Underline border styling
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorProperties
                                        .darkColor, // Label text color
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25), // Spacer
                              TextFormField(
                                obscureText: isPasswordObs,
                                controller: _passwordController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please confirm your password'; // Validation for empty confirm password
                                  }
                                  if (value.length <= 8) {
                                    return 'Password must be at least 8 characters long';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _password = value; // Set password value
                                  });
                                },
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorProperties.darkColor,
                                          width:
                                              2)), // Underline border styling
                                  suffixIcon: IconButton(
                                    onPressed:
                                        showPass, // Toggle password visibility
                                    icon: icon, // Password visibility icon
                                  ),
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorProperties
                                        .darkColor, // Label text color
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25), // Spacer
                              TextFormField(
                                obscureText: isPasswordObs,
                                controller: _confirmPasswordController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please confirm your password'; // Validation for empty confirm password
                                  }
                                  if (value != _password) {
                                    return 'Passwords do not match'; // Validation for mismatched passwords
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorProperties.darkColor,
                                          width:
                                              2)), // Underline border styling
                                  labelText: 'Confirm Password',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorProperties
                                        .darkColor, // Label text color
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(height: 40), // Spacer
                            Container(
                              decoration: BoxDecoration(
                                gradient: ColorProperties.mainColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: ElevatedButton(
                                onPressed:
                                    register, // Handle registration on tap
                                style: ElevatedButton.styleFrom(
                                  elevation: 10,
                                  backgroundColor: Colors
                                      .transparent, // Button background color
                                      foregroundColor: Colors.transparent,
                                      surfaceTintColor: Colors.transparent,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 50),
                                ),
                                child: Text(
                                  'REGISTER',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 40), // Spacer
                            Text(
                              "Already have an Account..?",
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const LoginPageScreen(), // Navigation to LoginPageScreen
                                  ),
                                );
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                    color: ColorProperties.darkColor,
                                    fontSize: 25,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
