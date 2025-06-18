import 'dart:convert';
import 'package:http/http.dart' as http;

class SmartApiAuthService {
  final String apiKey = '9TpKl7KG';
  final String clientCode = 'S1968092';
  final String password = 'tz&cW!7Fn';
  final String totp = '201620';

  Future<String?> generateSessionToken() async {
    final url = Uri.parse('https://apiconnect.angelbroking.com/rest/auth/angelbroking/user/v1/loginByPassword');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-PrivateKey': apiKey,
      },
      body: jsonEncode({
        "clientcode": clientCode,
        "password": password,
        "totp": totp
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data']['jwtToken'];
    } else {
      print('Failed to login: ${response.body}');
      return null;
    }
  }
}
