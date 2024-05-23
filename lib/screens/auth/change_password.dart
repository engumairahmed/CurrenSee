import 'package:currensee/api_tasks.dart';
import 'package:currensee/app_properties.dart';
import 'package:currensee/preferences.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _password = '';
  String _oldPassword = "";

  bool isPasswordObs = true;

  Icon icon = Icon(Icons.visibility, color: Colors.grey);

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

  Future<void> updatePassword() async {
    if (_formKey.currentState!.validate()) {
      var user = await getUserData();
      var email = user.email.toString();
      var res = await changePasswordTask(
          email, _oldPasswordController.text, _newPasswordController.text);
      if (res["status"]) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(res["message"])),
        );
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pop(context);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(res["message"])),
        );
        _oldPasswordController.dispose();
        _newPasswordController.dispose();
        _confirmPasswordController.dispose();
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Update Password'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    obscureText: isPasswordObs,
                    controller: _oldPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your old password';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _oldPassword = value; // Set password value
                      });
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: showPass,
                        icon: icon,
                      ),
                      labelText: 'Old Password',
                      labelStyle: TextStyle(color: ColorProperties.darkColor),
                      focusColor: ColorProperties.darkColor,
                      fillColor: ColorProperties.darkColor,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorProperties.darkColor, width: 2)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: ColorProperties.darkColor,
                      )),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    obscureText: isPasswordObs,
                    controller: _newPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a new password';
                      } if (value == _oldPassword){
                        return 'New password cannot be same as old password';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _password = value; // Set password value
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      labelStyle: TextStyle(color: ColorProperties.darkColor),
                      focusColor: ColorProperties.darkColor,
                      fillColor: ColorProperties.darkColor,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorProperties.darkColor, width: 2)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: ColorProperties.darkColor,
                      )),
                    ),
                  ),
                  SizedBox(height: 20),
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
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(color: ColorProperties.darkColor),
                      focusColor: ColorProperties.darkColor,
                      fillColor: ColorProperties.darkColor,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorProperties.darkColor, width: 2)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: ColorProperties.darkColor,
                      )),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      gradient: ColorProperties.mainColor,
                      borderRadius: BorderRadius.circular(
                          30), // Optional: Set border radius
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
                      onPressed: updatePassword,
                      child: Text(
                        'Update Password',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )),
        ));
  }
}
