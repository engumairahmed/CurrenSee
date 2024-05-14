import 'dart:convert';

import 'package:currensee/ApiTasks.dart';
import 'package:currensee/models/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setuser(String id) async {
  SharedPreferences shared = await SharedPreferences.getInstance();
  shared.setString("user_id", id);
  // print(shared.getString("user_id"));
}

Future<String?> getUser() async {
  SharedPreferences shared = await SharedPreferences.getInstance();
  var id = shared.getString("user_id");
  if(id==null){

    return null;

  } else{

  return id;
  }
}

Future<UserModel> getUserData() async {
  SharedPreferences shared = await SharedPreferences.getInstance();
  var id = shared.getString("user_id");
  var data= await userDataTask(id!);
  var user = UserModel.convertFromJson(jsonDecode(data!));
  return user;
}