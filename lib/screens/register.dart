import 'package:currensee/api_tasks.dart';
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
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _password = '';
  String _confirmPassword = '';
  String emailError = '';

  bool isPasswordObs = true;

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

  Future<void> register() async {
    if (_formKey.currentState!.validate()) {
      var res = await registerTask(_nameController.text, _emailController.text,
          _passwordController.text);
      var res2 = res.keys.toList();
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
            gradient: ColorProperties.mainColor,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Create Account",
                      style: GoogleFonts.badScript(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 47,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.sizeOf(context).height,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              ColorProperties.darkColor,
                                          width: 2)),
                                  labelText: 'Name',
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
                                controller: _emailController,
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              ColorProperties.darkColor,
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
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              ColorProperties.darkColor,
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
                              TextFormField(
                                obscureText: isPasswordObs,
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
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              ColorProperties.darkColor,
                                          width: 2)),
                                  labelText: 'Confirm Password',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorProperties.darkColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                elevation: 10,
                                backgroundColor: Colors.white,
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
                            // Add space between the two text widgets
                            SizedBox(
                              height: 40,
                            ),
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
                                        const LoginPageScreen(),
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
