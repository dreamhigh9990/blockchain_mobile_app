import 'dart:convert';
import 'dart:developer';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show utf8;
import 'dart:convert' show json;
import 'dart:convert' show base64;

class BinanceApi {
  static const String apiKey =
      '8SOl1OSEqFBI6nuleVOCTKC3uVDgnagTfHJjfvvugAsi1E4ZwWrPr8UctMkz5b5F';
  static const String apiSecret =
      'zldH1w1hruCFFz6W5rW2yTcJ6crWELvhmYxEw3KOp19YPQ8MpS9y0wXvfrFwi47G';
  static const String apiUrl = 'https://api.binance.com/api/v3/order';

  static Future<Map<String, dynamic>> placeOrder({
    required String symbol,
    required String side,
    required String type,
    required String quantity,
    required String price,
  }) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'X-MBX-APIKEY': apiKey,
    };

    final Map<String, String> params = {
      'symbol': symbol,
      'side': side,
      'type': type,
      'quantity': quantity,
      'price': price,
      'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
    };
    log('Request parameters: $params');
    params['signature'] = generateSignature(params);
    log('Request headers: $headers');
    final response =
        await http.post(Uri.parse(apiUrl), headers: headers, body: params);
    log('Response status code: ${response.statusCode}');
    log('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to place order: ${response.statusCode}');
    }
  }

  static String generateSignature(Map<String, String> params) {
    final query = params.entries.map((e) => '${e.key}=${e.value}').join('&');
    final signature =
        Hmac(sha256, utf8.encode(apiSecret)).convert(utf8.encode(query));
    return base64.encode(signature.bytes);
  }
}
