import 'dart:convert';

import 'package:currensee/ApiEndpoints.dart';
import 'package:currensee/Preferences.dart';
import 'package:currensee/models/HistoricalRates.dart';
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
    catch(error){
      
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
    catch(error){
      print(error.toString());
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
    catch(error){
        print(error.toString());
        return null;
    }
  }

  Future<void> feedbackTask(String message, int rating) async {
    try{
      Map<String, dynamic> data = {
      'message': message,
      'rating':rating,
      'id':await getUser(),
    };

    String body = jsonEncode(data);

    http.Response response = await http.post(
      Uri.parse(feedbackurl),
      body: body,
    );

    var res = jsonDecode(response.body);

    if(response.statusCode==200){
      print(res[0]);
      print("Feedback Success");
      
    }else{
      print("Feedback Failure");
    }
    }
    catch(error){
        print(error.toString());
        return;
    }
  }


  Future<Map<String,dynamic>> conversionTask(String baseCurrency,String targetCurrency, String amount) async{
    try{
      Map<String, dynamic> data = {
      'base': baseCurrency,
      'target':targetCurrency,
      'id':4,
      'amount':amount
    };

    String body = jsonEncode(data);

    http.Response response = await http.post(
      Uri.parse(conversionUrl),
      body: body,
    );

    var res = jsonDecode(response.body);

    if(response.statusCode==200){
      // print(res);
      // print("Conversion Success");
      return {"rate":res["exchange_rate"],"amount":res["converted_amount"]};
      
    }else{
      print("Feedback Failure");
      return {"message":"API Failure"};
    }
    }
    catch(error){
        print(error.toString());
        return {};
    }
  }

  Future<List<HistoricalRates>> historicalRateTask(int month, int year, String currency) async {
    try{
      Map<String, dynamic> data = {
      'month': month,
      'year': year,
      'currencyCode': currency
    };

    String body = jsonEncode(data);

    http.Response response = await http.post(
      Uri.parse(historicalRatesURL),
      body: body,
    );

    List<dynamic> result = jsonDecode(response.body);

    var res = result.map((e) => HistoricalRates.convertFromJson(e)).toList();

    if(response.statusCode==200){
      print(res);
      print("History Rates Success");
      return res;
      
    }else{
      print("Feedback Failure");
      return [];
    }
    }
    catch(error){
        print(error.toString());
        return [];
    }
  }