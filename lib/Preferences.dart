import 'dart:convert';

import 'package:currensee/api_tasks.dart';
import 'package:currensee/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setuser(String id) async {
  SharedPreferences shared = await SharedPreferences.getInstance();
  shared.setString("user_id", id);
  print(shared.getString("user_id"));
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

Future<String> getId() async {
SharedPreferences shared = await SharedPreferences.getInstance();
  var id = shared.getString("user_id").toString();
   return id;
}

Future<UserModel> getUserData() async {
  SharedPreferences shared = await SharedPreferences.getInstance();
  var id = shared.getString("user_id");
  var data= await userDataTask(id!);
  var user = UserModel.convertFromJson(jsonDecode(data!));
  return user;
}

Future<void> removeUser() async {
  SharedPreferences shared = await SharedPreferences.getInstance();
  shared.remove("user_id");
  shared.clear();
}

Future<void> setUserPreferences(String BaseCurrency, String TargetCurrency, String Notification) async {
SharedPreferences shared = await SharedPreferences.getInstance();
shared.setString('baseCurrency', BaseCurrency);
shared.setString('targetCurrency', TargetCurrency);
shared.setString('notification', Notification);
}