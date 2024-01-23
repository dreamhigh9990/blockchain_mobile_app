import 'dart:convert';
import 'dart:developer';
import 'package:blockchain_mobile_app/core/constant/api_constants.dart';
import 'package:blockchain_mobile_app/core/exceptions/exceptions.dart';
import 'package:blockchain_mobile_app/core/header_provider/header_provider.dart';
import 'package:http/http.dart' as http;

abstract class KlineRemote {
  Future<List<List<dynamic>>> kline(
      String symbol, String interval, String limit);
}

class KlineRemoteImpl implements KlineRemote {
  // static const klineEndpoint =
  //     ApiConstants.baseCommonApiUrl + ApiConstants.kline;
  final HeaderProvider _apiHeaderProvider;

  KlineRemoteImpl(this._apiHeaderProvider);

  @override
  Future<List<List<dynamic>>> kline(
      String symbol, String interval, String limit) async {
    var klineEndpoint = ApiConstants.baseCommonApiUrl +
        ApiConstants.kline +
        '?symbol=$symbol&interval=$interval&limit=$limit';
    try {
      final headers = _apiHeaderProvider();
      log("header ::::  ${json.encode(headers)}");

      final response =
          await http.get(Uri.parse(klineEndpoint), headers: headers);
      log(json.encode(response.body));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return List<List<dynamic>>.from(jsonList);
      } else {
        final errorBody = jsonDecode(response.body);
        final errorMessage = errorBody['error']['message'];

        throw ServerException(
          message: errorMessage,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      // Handle any other exceptions
      log("Exception in kline request: $e");
      rethrow;
    }
  }
}
