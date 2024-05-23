import 'package:currensee/api_tasks.dart';
import 'package:currensee/app_properties.dart';
import 'package:currensee/preferences.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConversionHistory extends StatefulWidget {
  const ConversionHistory({super.key});

  @override
  State<ConversionHistory> createState() => _ConversionHistoryState();
}

class _ConversionHistoryState extends State<ConversionHistory> {
  List<Map<String, dynamic>> history=[];

  Future<void> conversionHistory() async {
    var id = await getUser();
    var _history = await conversionHistoryTask(id!);
    if(_history['status']) {
      
      setState(() {
        history = List<Map<String, dynamic>>.from(_history['data']);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    conversionHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('History')),
      body: history.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final record = history[index];

                final dateFormat = DateFormat.yMd(); // Date format
                final timeFormat = DateFormat.Hms(); // Time format

                final dateTime = DateTime.parse(record['date']);

                // Format date and time
                final formattedDate = dateFormat.format(dateTime);
                final formattedTime = timeFormat.format(dateTime);
                return Card(
                  elevation: 5,
                  color: Color(0xFF00203f),
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text(
                      formattedDate,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white),
                      ),
                      Text(
                      record['base'],
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: ColorProperties.lightColor ,
                        ),
                      Text(
                      record['target'],
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                      ), 
                                           
                    ],
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          formattedTime,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white),
                          
                        ),
                        SizedBox(
                            width: 40,
                          ),
                        Text(
                          record['amount'],
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white),
                        ),
                        SizedBox(
                            width: 40,
                          ),
                        Text(
                            record['rate'],
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                        Text(
                          record['converted_amount'],
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white),
                        ),
                      ],
                    ),
                    
                    
                  ),
                );
              },
            ),
    );
  }
}