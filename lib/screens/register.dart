import 'package:currensee/api_tasks.dart'; // Importing API tasks
import 'package:currensee/screens/login.dart'; // Importing login screen
import 'package:flutter/material.dart'; // Importing Flutter material package
import 'package:google_fonts/google_fonts.dart'; // Importing Google Fonts
import 'package:currensee/app_properties.dart'; // Importing app properties for styling

class RegisterPageScreen extends StatefulWidget {
  const RegisterPageScreen({Key? key}) : super(key: key);

  @override
  State<RegisterPageScreen> createState() => _RegisterPageScreenState(); // Creating state for RegisterPageScreen
}

class _RegisterPageScreenState extends State<RegisterPageScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Key for the form
  final TextEditingController _nameController = TextEditingController(); // Controller for name input
  final TextEditingController _emailController = TextEditingController(); // Controller for email input
  final TextEditingController _passwordController = TextEditingController(); // Controller for password input
  final TextEditingController _confirmPasswordController = TextEditingController(); // Controller for confirm password input

  String _password = ''; // Variable to store password
  String _confirmPassword = ''; // Variable to store confirm password
  String emailError = ''; // Variable to store email error message

  bool isPasswordObs = true; // Variable to toggle password visibility

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

  // Function to handle registration
  Future<void> register() async {
    if (_formKey.currentState!.validate()) { // Validate form
      var res = await registerTask(
          _nameController.text, _emailController.text, _passwordController.text, 'null'); // Perform registration task
      var res2 = res.keys.toList();
      print(res);
      print(res2);

      if (res[res2[0]]!) { // If registration is successful
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(res2[0])), // Show success message
        );
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPageScreen())); // Navigate to LoginPageScreen
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
          height: MediaQuery.of(context).size.height, // Get the height of the screen
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
                  height: MediaQuery.sizeOf(context).height, // Get the height of the screen
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
                                          width: 2)), // Underline border styling
                                  labelText: 'Name',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorProperties.darkColor, // Label text color
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
                                          width: 2)), // Underline border styling
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorProperties.darkColor, // Label text color
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25), // Spacer
                              TextFormField(
                                obscureText: isPasswordObs,
                                controller: _passwordController,
                                onChanged: (value) {
                                  setState(() {
                                    _password = value; // Set password value
                                  });
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
                              const SizedBox(height: 25), // Spacer
                              TextFormField(
                                obscureText: isPasswordObs,
                                controller: _confirmPasswordController,
                                onChanged: (value) {
                                  setState(() {
                                    _confirmPassword = value; // Set confirm password value
                                  });
                                },
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
                                          width: 2)), // Underline border styling
                                  labelText: 'Confirm Password',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorProperties.darkColor, // Label text color
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(height: 40), // Spacer
                            ElevatedButton(
                              onPressed: register, // Handle registration on tap
                              style: ElevatedButton.styleFrom(
                                elevation: 10,
                                backgroundColor: Colors.white, // Button background color
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 50),
                              ),
                              child: Text(
                                'REGISTER',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorProperties.darkColor,
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold,
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
                                    builder: (context) => const LoginPageScreen(), // Navigation to LoginPageScreen
                                  ),
                                );
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: ColorProperties.darkColor,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
