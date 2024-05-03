import 'package:currensee/ApiTasks.dart';
import 'package:currensee/screens/home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
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
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
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
                'Welcome To CurrenSee!',
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
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email', 
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 118, 51, 170),
                          ),
                        ),
                      ),
                      TextFormField(
                        obscureText: isPasswordObs,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          suffixIcon:
                              IconButton(onPressed: showPass,icon: Icon(Icons.visibility_off, color: Colors.grey),),
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
                        child: TextButton(
                          onPressed: (){},
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                              color: Color.fromARGB(255, 118, 51, 170),
                            ),
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
                          child: TextButton(
                            onPressed: () {
                              
                            },
                            child: Text('LOG IN',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,)
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
                            TextButton(
                              onPressed: (){},
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Color.fromARGB(255, 215, 15, 233),
                                ),
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