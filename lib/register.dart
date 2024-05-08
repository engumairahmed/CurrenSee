import 'package:currensee/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class RegisterScreen extends StatelessWidget{
  const RegisterScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: Stack(
        children: [
          Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 118, 51, 170),
                Color.fromARGB(255, 215, 15, 233),
              ]
          ),
        ),
        child: const Padding(
          padding:  EdgeInsets.only(top: 40.0, left: 22),
          child: Text('Create Your Account!', style: TextStyle(
            fontSize: 40,
            fontFamily: AutofillHints.birthday,
            color: Colors.white,
            fontWeight: FontWeight.bold

          ),),
        ),
      ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),topRight: Radius.circular(40)
            ),

              color: Colors.white,
            ),
              height: double.infinity,
              width: double.infinity,

              child:  Padding(
                padding: const EdgeInsets.only(left: 18.0,right: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TextField(
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.check, color: Colors.grey),
                        label: Text('Name', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:Color.fromARGB(255, 118, 51, 170),

                        ),)
                      ),
                    ),
                     const TextField(
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.check, color: Colors.grey),
                        label: Text('Gmail', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:Color.fromARGB(255, 118, 51, 170),

                        ),)
                      ),
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.visibility_off, color: Colors.grey),
                        label: Text('Password', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:Color.fromARGB(255, 118, 51, 170),
                        ),)
                      ),
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.visibility_off, color: Colors.grey),
                        label: Text('Confirm Password', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:Color.fromARGB(255, 118, 51, 170),
                        ),)
                      ),
                    ),
                   
                    const SizedBox(height: 30,),
                     Container(
                      height: 55,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient:  ColorProperties.gradientcolor,
                      ),
                      child: const Center(child: Text('Register', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white
                      ),),),

                    ),
                        const SizedBox(height: 80,),

                    const Align(
                      alignment: Alignment.center,
                      child: Column(
                      children: [
                        Text('Already have an account?', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:Color.fromARGB(255, 118, 51, 170),
                          fontSize: 15,

                        ),),
                        Text('LogIn', style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 30,
                          color:Color.fromARGB(255, 215, 15, 233),


                        ),)
                        
                      ],
                      ),
                    )
                
                
                    
                  ],
                  ),
              ),
            ),
          )
],
        ));
    
  }
}