import 'dart:async';

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

Future<void> setUserData() async {
  SharedPreferences shared = await SharedPreferences.getInstance();
  var id = shared.getString("user_id");
  var data = await userDataTask(id!);
  shared.setString("user_name", data!.name);
  shared.setString("user_email", data.email);
  shared.setString("user_pass", data.password);
  print(shared.getString("user_name"));
  print(shared.getString("user_email"));
  print(shared.getString("user_pass"));

}

Future<UserModel> getUserData() async {
  SharedPreferences shared = await SharedPreferences.getInstance();
  var id = shared.getString("user_id");
  var name = shared.getString("user_name");
  var email = shared.getString("user_email");
  var password = shared.getString("user_pass");
  if(id==null || name==null || email==null || password==null){
    print('Null or empty user');
    return UserModel(
      id: "",
      name: "",
      email: "",
      password: "",
    );
  
  } else{
  UserModel user = UserModel(
    id: id,
    name: name,
    email: email,
    password: password,
  );
  print(user.name+" "+user.email+" "+user.password);
  return user;
  }
}

Future<void> removeUser() async {
  SharedPreferences shared = await SharedPreferences.getInstance();
  shared.remove("user_id");
  shared.clear();
}

Future<void> setUserPreferences({required String BaseCurrency,required String TargetCurrency,required bool Notification}) async {
  SharedPreferences shared = await SharedPreferences.getInstance();
  shared.setString('baseCurrency', BaseCurrency);
  shared.setString('targetCurrency', TargetCurrency);
  shared.setBool('notification', Notification);
}

Future<Map<String,dynamic>> getUserPreferences() async {
  SharedPreferences shared = await SharedPreferences.getInstance();
  var baseCurrency = shared.getString('baseCurrency');
  var targetCurrency = shared.getString('targetCurrency');
  var notification = shared.getBool('notification');
  if(baseCurrency==null || targetCurrency==null){
    print('SharedPreferences not found');
    return {
      'status':false
    };
  }else{

    return {
        'status':true,
        'baseCurrency': baseCurrency,
        'targetCurrency': targetCurrency,
        'notification': notification
      };
  }
  
}