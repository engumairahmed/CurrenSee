import 'package:currensee/api_tasks.dart';
import 'package:currensee/models/historical_rates.dart';
import 'package:currensee/screens/AppBar.dart';
import 'package:currensee/screens/drawer.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  List<HistoricalRates> chartData = [];

  // Month mapping
  final Map<int, String> months = {
    01: 'January',
    02: 'February',
    03: 'March',
    04: 'April',
    05: 'May',
    06: 'June',
    07: 'July',
    08: 'August',
    09: 'September',
    10: 'October',
    11: 'November',
    12: 'December',
  };

  List<int> years = [2023, 2024];
  List<String> currencies = ['USD', 'EUR', 'CAD'];

  int selectedMonth = 1;
  int selectedYear = 2024;
  String selectedCurrency = 'USD';

  late TooltipBehavior _tooltipBehavior;

  Future<void> updateChartData(int month, int year, String currency) async {
    var res = await historicalRateTask(month, year, currency);
    setState(() {
      chartData = res;
    });
  }

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
    print('Historical chart Launched');
    updateChartData(selectedMonth, selectedYear, selectedCurrency);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: RoundAppBar(pageTitle: 'Historical Rates'),
      drawer: CustomDrawer(),
      body: Column(
        children: [
          Form(
            child: Row(
              children: [
                // Dropdown for Month
                DropdownButton<int>(
                  value: selectedMonth,
                  items: months.keys.map((int month) {
                    return DropdownMenuItem<int>(
                      value: month,
                      child: Text(months[month]!),
                    );
                  }).toList(),
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedMonth = newValue!;
                      updateChartData(
                          selectedMonth, selectedYear, selectedCurrency);
                    });
                  },
                ),
                // Dropdown for Year
                DropdownButton<int>(
                  value: selectedYear,
                  items: years.map((int year) {
                    return DropdownMenuItem<int>(
                      value: year,
                      child: Text(year.toString()),
                    );
                  }).toList(),
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedYear = newValue!;
                      updateChartData(
                          selectedMonth, selectedYear, selectedCurrency);
                    });
                  },
                ),
                // Dropdown for Currency Code
                DropdownButton<String>(
                  value: selectedCurrency,
                  items: currencies.map((String currency) {
                    return DropdownMenuItem<String>(
                      value: currency,
                      child: Text(currency),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCurrency = newValue!;
                      updateChartData(
                          selectedMonth, selectedYear, selectedCurrency);
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    'PKR',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 2.2,
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: SfCartesianChart(
                              primaryXAxis: DateTimeAxis(
                                intervalType: DateTimeIntervalType.days,
                                interval: 1,
                              ),
                              tooltipBehavior: _tooltipBehavior,
                              series: <CartesianSeries>[
                                // Renders line chart
                                LineSeries<HistoricalRates, DateTime>(
                                  dataSource: chartData,
                                  xValueMapper: (HistoricalRates rates, _) => rates.month,
                                  yValueMapper: (HistoricalRates rates, _) => rates.rate,
                                  // Show data points as markers
                                  markerSettings:
                                      MarkerSettings(isVisible: true),
                                  enableTooltip: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Transform.rotate(
                        angle:0,
                        child: Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: Text(
                            months[selectedMonth]!,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
