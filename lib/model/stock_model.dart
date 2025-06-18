// lib/model/stock_model.dart
class Stock {
  final String tradingSymbol;
  final double percentChange;
  final int symbolToken;
  final int opnInterest;
  final double netChangeOpnInterest;

  Stock({
    required this.tradingSymbol,
    required this.percentChange,
    required this.symbolToken,
    required this.opnInterest,
    required this.netChangeOpnInterest,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      tradingSymbol: json['tradingSymbol'] ?? 'N/A',
      percentChange: (json['percentChange'] ?? 0).toDouble(),
      symbolToken: json['symbolToken'] ?? 0,
      opnInterest: json['opnInterest'] ?? 0,
      netChangeOpnInterest: (json['netChangeOpnInterest'] ?? 0).toDouble(),
    );
  }
}
