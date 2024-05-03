import 'dart:convert';

import 'package:currensee/ApiEndpoints.dart';
import 'package:currensee/Preferences.dart';
import 'package:http/http.dart' as http;

Future<Map<String,bool>> registerTask(String name, String email, String password) async{

    try{
    Map<String, dynamic> data = {
      'name': name,
      'email': email,
      'password':password,
    };

    String body = jsonEncode(data);

    http.Response response = await http.post(
      Uri.parse(registerurl),
      body: body,
    );

    var res = jsonDecode(response.body);

    if(response.statusCode==200){
      print(response.body);
      return {res["message"]:true};
    }else{
      return {res["message"]:false};
    }
    }
    catch(Error){
        return {"Server / Api not reachable":false};
    }
  }

  Future<Map<String,bool>> loginTask(String email, String pass) async{
    try{
    Map<String, dynamic> data = {
      'email': email,
      'password':pass,
    };

    String body = jsonEncode(data);

    http.Response response = await http.post(
      Uri.parse(loginurl),
      body: body,
    );

    var res = jsonDecode(response.body);

    if(response.statusCode==200){
      setuser(res["user"]["id"]);

      return {res["message"]:true};
    }else{
      return {res["message"]:false};
    }
    }
    catch(Error){
        return {"Server / Api not reachable":false};
    }
  }

  Future<String?> userDataTask(String id) async{
    try{

    http.Response response = await http.post(
      Uri.parse(userDataUrl+id),
    );
    if(response.statusCode==200){
     
      return response.body;
    }else{
      return null;
    }
    }
    catch(Error){
        print(Error.toString());
        return null;
    }
  }