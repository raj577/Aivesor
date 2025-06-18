import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/stock_model.dart';

class StockRepository {
  Future<List<Stock>> fetchTopGainers() async {
    final url = 'https://your-api-url.com'; // Replace with actual API URL
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List<dynamic> dataList = body['data'];
      return dataList.map((item) => Stock.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load top gainers');
    }
  }
}
