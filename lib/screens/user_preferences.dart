import 'package:currensee/api_tasks.dart';
import 'package:flutter/material.dart';

class UserPreferences extends StatefulWidget {
  const UserPreferences({super.key});

  @override
  State<UserPreferences> createState() => _UserPreferencesState();
}

class _UserPreferencesState extends State<UserPreferences> {

  String _baseCurrency = 'PKR';
  String _targetCurrency = 'USD';
  bool _notificationsEnabled = false;

  List<String> _currencyCodes = [];  

  Future<void> _fetchCurrencyCodes() async {
    try {
      _currencyCodes = await fetchCurrencyCodes();
      setState(() {
        _baseCurrency = _currencyCodes.isNotEmpty ? _currencyCodes[0] : '';
        _targetCurrency = _currencyCodes.isNotEmpty ? _currencyCodes[0] : '';
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCurrencyCodes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
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
              'Default Base Currency',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
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
            SwitchListTile(
              title: Text('Enable Notifications'),
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to change password screen
              },
              child: Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }
}
