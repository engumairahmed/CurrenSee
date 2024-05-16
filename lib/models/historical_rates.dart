class HistoricalRates{

  HistoricalRates({required this.month, required this.rate});

  late DateTime month;
  late double rate;

  static HistoricalRates convertFromJson(Map<String, dynamic> json){
    return HistoricalRates(
      month: DateTime.parse(json['LastUpdatedAt']),
      rate: 1/double.parse(json['ExchangeRate']),
    );
  }
}