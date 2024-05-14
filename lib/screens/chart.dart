import 'package:currensee/ApiTasks.dart';
import 'package:currensee/models/HistoricalRates.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';



class ChartScreen extends StatefulWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {

  late TooltipBehavior _tooltipBehavior;

  // Future<void> historicalRate() async{
  //   var res = await historicalRateTask(month, year,)
  // }

  @override
  void initState() {
        _tooltipBehavior = TooltipBehavior(enable: true);
        super.initState();
      }

  final List<HistoricalRates> chartData = [
    HistoricalRates(month: DateTime.parse('2024-02-01T23:59:59Z'),rate: 220),
    HistoricalRates(month: DateTime.parse('2024-02-02T23:59:59Z'),rate: 225),
    HistoricalRates(month: DateTime.parse('2024-02-03T23:59:59Z'),rate: 230),
    HistoricalRates(month: DateTime.parse('2024-02-04T23:59:59Z'),rate: 240),
    HistoricalRates(month: DateTime.parse('2024-02-05T23:59:59Z'),rate: 250),
    HistoricalRates(month: DateTime.parse('2024-02-06T23:59:59Z'),rate: 290),
    HistoricalRates(month: DateTime.parse('2024-02-07T23:59:59Z'),rate: 210),
    HistoricalRates(month: DateTime.parse('2024-02-08T23:59:59Z'),rate: 215),
    HistoricalRates(month: DateTime.parse('2024-02-09T23:59:59Z'),rate: 220),
    HistoricalRates(month: DateTime.parse('2024-02-10T23:59:59Z'),rate: 190),
    HistoricalRates(month: DateTime.parse('2024-02-11T23:59:59Z'),rate: 185),
    HistoricalRates(month: DateTime.parse('2024-02-12T23:59:59Z'),rate: 200),
    HistoricalRates(month: DateTime.parse('2024-02-13T23:59:59Z'),rate: 220),
    HistoricalRates(month: DateTime.parse('2024-02-14T23:59:59Z'),rate: 260),
    HistoricalRates(month: DateTime.parse('2024-02-15T23:59:59Z'),rate: 280),
    HistoricalRates(month: DateTime.parse('2024-02-16T23:59:59Z'),rate: 285),
    HistoricalRates(month: DateTime.parse('2024-02-17T23:59:59Z'),rate: 290),
    HistoricalRates(month: DateTime.parse('2024-02-18T23:59:59Z'),rate: 310),
  ];


 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height/2.2,
          width: MediaQuery.of(context).size.width/1.2,
          child: SfCartesianChart(
            primaryXAxis: DateTimeAxis(
              intervalType: DateTimeIntervalType.days,
              interval: 2,
            ),
            tooltipBehavior: _tooltipBehavior,
            series: <CartesianSeries>[
              // Renders line chart
              LineSeries<HistoricalRates, DateTime>(
                dataSource: chartData,
                xValueMapper: (HistoricalRates rates, _) => rates.month,
                yValueMapper: (HistoricalRates rates, _) => rates.rate,
                // Show data points as markers
                markerSettings: MarkerSettings(isVisible: true),
                enableTooltip: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

}
