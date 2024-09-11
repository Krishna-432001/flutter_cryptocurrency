import 'dart:convert';
import 'package:http/http.dart' as http;

class CryptoService {
  final String apiUrl = "https://api.coingecko.com/api/v3/coins/markets";
  final String currency = "usd"; // You can change to other currencies like EUR, GBP, etc.

  Future<List<dynamic>> getCryptoData() async {
    final response = await http.get(
        Uri.parse('$apiUrl?vs_currency=$currency&order=market_cap_desc&per_page=10&page=1&sparkline=false')
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load cryptocurrency data");
    }
  }
}
