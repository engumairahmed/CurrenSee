class HistoricalRates{

  HistoricalRates({required this.month, required this.rate});

  late DateTime month;
  late double rate;

  static HistoricalRates convertFromJson(Map<String, dynamic> json){
    return HistoricalRates(
      month: json["month"],
      rate: json["rates"]
    );
  }
}