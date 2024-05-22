import 'dart:convert';

import 'package:currensee/api_endpoints.dart';
import 'package:currensee/models/user_model.dart';
import 'package:currensee/preferences.dart';
import 'package:currensee/models/historical_rates.dart';
import 'package:http/http.dart' as http;

Future<Map<String,bool>> registerTask(String? name, String? email, String? password, String? uid) async{

    try{
    Map<String, dynamic> data = {
      'name': name,
      'email': email,
      'password':password,
      'uid': uid
    };

    String body = jsonEncode(data);

    http.Response response = await http.post(
      Uri.parse(registerurl),
      body: body,
    );

    var res = jsonDecode(response.body);

    if(response.statusCode==200){
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
        setUserData();

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

  Future<UserModel?> userDataTask(String id) async{
    try{

    http.Response response = await http.post(
      Uri.parse(userDataUrl+id),
    );
    if(response.statusCode==200){
     var user = UserModel.convertFromJson(jsonDecode(response.body));
      return user;
    }else{
      return null;
    }
    }
    catch(error){
        print(error.toString());
        return null;
    }
  }

    Future<bool?> uidCheckTask(String uid) async{
    try{

    http.Response response = await http.post(
      Uri.parse(uidCheckUrl+uid),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['exists'];
    } else {
      return false;
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

      if(response.statusCode==200){
        
      }else{
        print("Feedback Failure");
      }
    }
    catch(error){
        print(error.toString());
        return;
    }
  }


  Future<Map<String,dynamic>> conversionTask(String baseCurrency,String targetCurrency, String amount, String id) async{
    try{
      
      Map<String, dynamic> data = {
      'base': baseCurrency,
      'target':targetCurrency,
      'id':id,
      'amount':amount
    };

    String body = jsonEncode(data);

    http.Response response = await http.post(
      Uri.parse(conversionUrl),
      body: body,
    );

    var res = jsonDecode(response.body);

    if(response.statusCode==200){
      return {"rate":res["exchange_rate"],"amount":res["converted_amount"]};
      
    }else{
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
      return res;
      
    }else{
      return [];
    }
    }
    catch(error){
        print(error.toString());
        return [];
    }
  }

Future<List<String>> fetchCurrencyCodes() async {
  try {
    final response = await http.get(Uri.parse(currencyCodesURL));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      List<String> currencyCodes =
          data.map((e) => e['CurrencyCode'].toString()).toList();
      return currencyCodes;
    } else {
      throw Exception('Failed to load currency codes');
    }
  } catch (e) {
    print(e.toString());
    return [];
  }
}

Future<Map<String, dynamic>> conversionHistoryTask(String id) async {
  try {
    http.Response response = await http.post(
      Uri.parse(conversionHistoryURL + id),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      print(data);
      List<Map<String, dynamic>> historyList = data.map((record) {
        return {
          'base': record['Base_Currency'],
          'target': record['Target_Currency'],
          'amount': record['Base_Amount'],
          'converted_amount': record['Converted_Amount'],
          'rate': record['Exchange_Rate'],
          'date': record['Date'],
        };
      }).toList();

      return {
        'status': true,
        'data': historyList,
      };
    } else if (response.statusCode == 404) {
      return {
        'status': false,
        'message': 'No Records Found',
      };
    } else {
      return {
        'status': false,
        'message': 'Failed to fetch data',
      };
    }
  } catch (error) {
    print(error.toString());
    return {
      'ApiFailed': true,
      'message': error.toString(),
    };
  }
}

Future<String> userPreferencesTask(String BaseCurrency, String TargetCurrency, String id, bool Notifications) async {

    try{
    Map<String, dynamic> data = {
      'baseCurrency': BaseCurrency,
      'targetCurrency': TargetCurrency,
      'notification':Notifications,
      'id': id
    };

    String body = jsonEncode(data);

    print(body);

    http.Response response = await http.post(
      Uri.parse(userPreferencesURL),
      body: body,
    );

    var res = jsonDecode(response.body);

    print(res);

    if(response.statusCode==200){
      print(res['message']);
      return res['message'];
    }else{
      print(res['message']);
      return res['message'];
    }
    }
    catch(error){      
      print(error.toString());
      return error.toString();
        // return {"Server / Api not reachable":false};
    }
}

Future<Map<String, dynamic>> fetchPreferencesTask(String id) async {

    try{
    http.Response response = await http.post(
      Uri.parse(getPreferencesURL+id)
    );

    var res = jsonDecode(response.body);

    if(response.statusCode==200){
      print('Preferences fetched successfully from API server');
      print(res[0]['Default_Base_Currency']);
      print(res[0]['Default_Target_Currency']);
      print(res[0]['Notification']);
      if(res[0]['Notification']=='1'){
        print('Result is true');
        print(res[0]['Notification']);
      } else {
        print('Result is false');
        print(res[0]['Notification']);
      }
      return {
        'APIStatus': true,
        'baseCurrency': res[0]['Default_Base_Currency'],
        'targetCurrency': res[0]['Default_Target_Currency'],
        'notification': res[0]['Notification'],        
      };
    }else{
      print('Preferences fetch Failed');
      return {
        'APIStatus': false
      };
    }
    }
    catch(error){      
      print(error.toString());
      return {'error':error.toString()};
    }
}