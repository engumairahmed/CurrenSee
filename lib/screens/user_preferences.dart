import 'package:currensee/api_tasks.dart';
import 'package:currensee/app_properties.dart';
import 'package:currensee/preferences.dart';
import 'package:currensee/screens/auth/change_password.dart';
import 'package:flutter/material.dart';

class UserPreferences extends StatefulWidget {
  const UserPreferences({super.key});

  @override
  State<UserPreferences> createState() => _UserPreferencesState();
}

class _UserPreferencesState extends State<UserPreferences> {
  String _baseCurrency = 'USD';
  String _targetCurrency = 'PKR';
  bool _notificationsEnabled = false;

  List<String> _currencyCodes = [];

  // Future<void> _fetchCurrencyCodes() async {
  //   try {
  //     _currencyCodes = await fetchCurrencyCodes();
  //     setState(() {
  //       _baseCurrency = _currencyCodes.isNotEmpty ? _currencyCodes[0] : '';
  //       _targetCurrency = _currencyCodes.isNotEmpty ? _currencyCodes[0] : '';
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  Future<void> _fetchCurrencyCodes() async {
    try {
      List<String> currencyCodes = await fetchCurrencyCodes();
      setState(() {
        _currencyCodes = currencyCodes;
        if (_currencyCodes.isNotEmpty) {
          // Ensure default values are part of the fetched list
          if (!_currencyCodes.contains(_baseCurrency)) {
            _baseCurrency = _currencyCodes[0];
          }
          if (!_currencyCodes.contains(_targetCurrency)) {
            _targetCurrency = _currencyCodes[0];
          }
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateUserPreference() async {

    var id = await getUser();

    await setUserPreferences(BaseCurrency: _baseCurrency,TargetCurrency: _targetCurrency,Notification: _notificationsEnabled);

    var res = await userPreferencesTask(
        _baseCurrency, _targetCurrency, id!, _notificationsEnabled);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(res)),
    );

  }

  Future<void> _getUserPreferences() async{
    var data = await getUserPreferences();
    if(data['status']){
      print('Fetched from SharedPreferences');

      setState(() {
        _targetCurrency = data['targetCurrency'];
        _baseCurrency = data['baseCurrency'];
        _notificationsEnabled = data['notification'];
      });
    } else{
      var id = await getUser();
      var data = await fetchPreferencesTask(id!);
      
      if(data['APIStatus']){
      print('Fetched from API');
      
       setState(() {
        _baseCurrency = data['baseCurrency'];
        _targetCurrency = data['targetCurrency'];
        _notificationsEnabled = data['notification'];
       });
       await setUserPreferences(
        BaseCurrency: data['baseCurrency'], 
        TargetCurrency: data['targetCurrency'], 
        Notification: _notificationsEnabled
        );

      }

    }
  }

  @override
  void initState() {
    super.initState();
    print('User Preference Screen Launched');
    _fetchCurrencyCodes();
    _getUserPreferences();   

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: [
          TextButton(
            onPressed: (){
              updateUserPreference();
            },
              child: Text(
                'SAVE',
                style: TextStyle(color: ColorProperties.darkColor),
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Preferences',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Default Target Currency',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                focusColor: ColorProperties.darkColor,
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorProperties.darkColor, width: 2)),
                border: OutlineInputBorder(),
              ),
              value: _targetCurrency,
              onChanged: (String? newValue) {
                setState(() {
                  _targetCurrency = newValue!;
                });
              },
              items: _currencyCodes.map((String currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Default Base Currency',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorProperties.darkColor, width: 2)),
                border: OutlineInputBorder(),
              ),
              value: _baseCurrency,
              onChanged: (String? newValue) {
                setState(() {
                  _baseCurrency = newValue!;
                });
              },
              items: _currencyCodes.map((String currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            SwitchListTile(
              activeColor: ColorProperties.darkColor,
              title: Text('Enable Notifications'),
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangePassword(),
                      ));
                },
                child: Text('Change Password',style: TextStyle(color: Colors.black),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
