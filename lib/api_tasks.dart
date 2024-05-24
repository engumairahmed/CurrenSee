import 'dart:convert';

import 'package:currensee/api_endpoints.dart';
import 'package:currensee/models/user_model.dart';
import 'package:currensee/preferences.dart';
import 'package:currensee/models/historical_rates.dart';
import 'package:http/http.dart' as http;

Future<Map<String, bool>> registerTask(
    String? name, String? email, String? password, String? uid) async {
  try {
    Map<String, dynamic> data = {
      'name': name,
      'email': email,
      'password': password,
      'uid': uid
    };

    String body = jsonEncode(data);

    http.Response response = await http.post(
      Uri.parse(registerurl),
      body: body,
    );

    var res = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return {res["message"]: true};
    } else {
      return {res["message"]: false};
    }
  } catch (error) {
    return {"Server / Api not reachable": false};
  }
}

Future<Map<String, bool>> loginTask(String email, String pass) async {
  try {
    Map<String, dynamic> data = {
      'email': email,
      'password': pass,
    };

    String body = jsonEncode(data);

    http.Response response = await http.post(
      Uri.parse(loginurl),
      body: body,
    );

    var res = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setuser(res["user"]["id"]);
      setUserData();

      return {res["message"]: true};
    } else {
      return {res["message"]: false};
    }
  } catch (error) {
    return {"Server / Api not reachable": false};
  }
}

Future<Map<String, dynamic>> changePasswordTask(
    String email, String oldpassword, String newpassword) async {
  try {
    Map<String, dynamic> data = {
      'email': email,
      'oldPassword': oldpassword,
      'newPassword': newpassword
    };

    String body = jsonEncode(data);

    http.Response response = await http.post(
      Uri.parse(userPasswordUpdateurl),
      body: body,
    );

    var res = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return {"status": true, "message": res["message"]};
    } else {
      return {"status": false, "message": res["message"]};
    }
  } catch (error) {
    return {"ApiFailed": true, "message": error.toString()};
  }
}

Future<UserModel?> userDataTask(String id) async {
  try {
    http.Response response = await http.post(
      Uri.parse(userDataUrl + id),
    );
    if (response.statusCode == 200) {
      var user = UserModel.convertFromJson(jsonDecode(response.body));
      return user;
    } else {
      return null;
    }
  } catch (error) {
    return null;
  }
}

Future<bool?> uidCheckTask(String uid) async {
  try {
    http.Response response = await http.post(
      Uri.parse(uidCheckUrl + uid),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['exists'];
    } else {
      return false;
    }
  } catch (error) {
    return null;
  }
}

Future<String> feedbackTask(String message, int rating) async {
  try {
    Map<String, dynamic> data = {
      'message': message,
      'rating': rating,
      'id': await getUser(),
    };

    String body = jsonEncode(data);

    http.Response response = await http.post(
      Uri.parse(feedbackurl),
      body: body,
    );

    var res = jsonDecode(response.body);

    return res["message"];
  } catch (error) {
    return error.toString();
  }
}

Future<Map<String, dynamic>> userFeedbackTask(String id) async {
  try {
    http.Response response = await http.post(
      Uri.parse(feedbackDataURL + id),
    );

    var res = jsonDecode(response.body);

    print(res);
    print("userFeedbackApi Called");
    if (response.statusCode == 200) {
      var Rating = int.parse(res['Rating']);
      assert(Rating is int);
      return {
        "status": true,
        "rating": Rating,
        "feedback": res["Message"]
      };
    } else {
      return {"status": false, "message": res["message"]};
    }
  } catch (error) {
    return {"ApiFailed": true, "message": error.toString()};
  }
}

Future<Map<String, dynamic>> conversionTask(String baseCurrency,
    String targetCurrency, String amount, String id) async {
  try {
    Map<String, dynamic> data = {
      'base': baseCurrency,
      'target': targetCurrency,
      'id': id,
      'amount': amount
    };

    String body = jsonEncode(data);

    http.Response response = await http.post(
      Uri.parse(conversionUrl),
      body: body,
    );

    var res = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return {"rate": res["exchange_rate"], "amount": res["converted_amount"]};
    } else {
      return {"message": "API Failure"};
    }
  } catch (error) {
    return {};
  }
}

Future<List<HistoricalRates>> historicalRateTask(
    int month, int year, String currency) async {
  try {
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

    if (response.statusCode == 200) {
      return res;
    } else {
      return [];
    }
  } catch (error) {
    return [];
  }
}

Future<List<String>> fetchCurrencyCodes() async {
  try {
    http.Response response = await http.post(
      Uri.parse(currencyCodesURL),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      List<String> currencyCodes =
          data.map((e) => e['CurrencyCode'].toString()).toList();
      return currencyCodes;
    } else {
      throw Exception('Failed to load currency codes: ${response.statusCode}');
    }
  } catch (e) {
    ;

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
    return {
      'ApiFailed': true,
      'message': error.toString(),
    };
  }
}

Future<String> userPreferencesTask(String BaseCurrency, String TargetCurrency,
    String id, bool Notifications) async {
  try {
    Map<String, dynamic> data = {
      'baseCurrency': BaseCurrency,
      'targetCurrency': TargetCurrency,
      'notification': Notifications,
      'id': id
    };

    String body = jsonEncode(data);

    http.Response response = await http.post(
      Uri.parse(userPreferencesURL),
      body: body,
    );

    var res = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print(res['message']);
      return res['message'];
    } else {
      print(res['message']);
      return res['message'];
    }
  } catch (error) {
    return error.toString();
    // return {"Server / Api not reachable":false};
  }
}

Future<Map<String, dynamic>> fetchPreferencesTask(String id) async {
  try {
    http.Response response = await http.get(
      Uri.parse(getPreferencesURL + id),
    );

    var res = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (res.isEmpty) {
        return {'APIStatus': true, 'message': 'No Data Found'};
      } else {
        if (res["Notification"] == "1") {
          return {
            'APIStatus': true,
            'baseCurrency': res['Default_Base_Currency'],
            'targetCurrency': res['Default_Target_Currency'],
            'notification': true,
          };
        } else {
          return {
            'APIStatus': true,
            'baseCurrency': res['Default_Base_Currency'],
            'targetCurrency': res['Default_Target_Currency'],
            'notification': false,
          };
        }
      }
    } else {
      return {'APIStatus': false, 'message': 'No Data Found'};
    }
  } catch (error) {
    return {'message': error.toString()};
  }
}
