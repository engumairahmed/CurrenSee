import 'package:currensee/models/HistoricalRates.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';



class ChartScreen extends StatefulWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  @override

  final List<HistoricalRates> chartData = [
    HistoricalRates(DateTime.parse('2002-01-05 20:20:20'), 2100),
    HistoricalRates(DateTime.parse('2003-02-06 12:40:30'), 2250),
    HistoricalRates(DateTime.parse('2004-03-07 10:25:10'), 2900),
    HistoricalRates(DateTime.parse('2005-04-08 17:50:15'), 3350),
    HistoricalRates(DateTime.parse('2006-05-09 20:20:20'), 4300),
    HistoricalRates(DateTime.parse('2007-06-10 12:40:30'), 5450),
    HistoricalRates(DateTime.parse('2008-07-11 10:25:10'), 6400),
    HistoricalRates(DateTime.parse('2009-08-12 17:50:15'), 7500),
  ];
 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 400,
          width: 350,
          child: SfCartesianChart(
            primaryXAxis: DateTimeAxis(),
            series: <CartesianSeries>[
              // Renders line chart
              LineSeries<HistoricalRates, DateTime>(
                dataSource: chartData,
                xValueMapper: (HistoricalRates rates, _) => rates.year,
                yValueMapper: (HistoricalRates rates, _) => rates.rates,
                // Show data points as markers
                markerSettings: MarkerSettings(isVisible: true),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
