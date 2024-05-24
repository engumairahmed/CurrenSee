// ignore: file_names
class CurrencyModel{
  late String id;
  late String name;
  late String code;
  late String symbol;

  CurrencyModel({
    required this.id,
    required this.name,
    required this.code,
    required this.symbol
});

  static CurrencyModel convertFromJson(Map<String, dynamic> json){
    return CurrencyModel(
      id: json["CurrencyId"],
      name: json["CurrencyName"],
      code: json["CurrencyCode"],
      symbol: json["CurrencySymbol"]
    );
  }
}