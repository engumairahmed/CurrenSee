import 'package:currensee/app_properties.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Update Password'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Old Password',
                  labelStyle: TextStyle(color: ColorProperties.darkColor),
                  focusColor: ColorProperties.darkColor,
                  fillColor: ColorProperties.darkColor,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: ColorProperties.darkColor,
                    width: 2
                  )),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: ColorProperties.darkColor,
                  )),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Container(
              decoration: BoxDecoration(
                gradient: ColorProperties.mainColor,
                borderRadius:
                    BorderRadius.circular(30), // Optional: Set border radius
              ),
              child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 20,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
                onPressed: () {
                 
                },
                child: Text('Update Password',style: TextStyle(color: Colors.black),),
              ),
            ),
            ],
          )),
        ));
  }
}
