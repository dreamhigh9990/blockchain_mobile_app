// import 'dart:convert';
// import 'dart:developer';
// import 'package:blockchain_mobile_app/core/constant/api_constants.dart';
// import 'package:blockchain_mobile_app/core/exceptions/exceptions.dart';
// import 'package:blockchain_mobile_app/core/header_provider/header_provider.dart';
// import 'package:blockchain_mobile_app/features/home/data/model/bitcoin_list_response.dart';
// import 'package:http/http.dart' as http;

// abstract class BitcoinListRemote {
//   Future<BitcoinListResponse> bitcoinList();
// }

// class BitcoinListRemoteImpl implements BitcoinListRemote {
//   static const bitcoinListEndpoint =
//       ApiConstants.baseCommonApiUrl + ApiConstants.bitcoinList;
//   final HeaderProvider _apiHeaderProvider;
//   BitcoinListRemoteImpl(this._apiHeaderProvider);

//   @override
//   Future<BitcoinListResponse> bitcoinList() async {
//     BitcoinListResponse res;
//     final headers = _apiHeaderProvider();
//     log("header ::::  ${json.encode(headers)}");

//     final response =
//         await http.get(Uri.parse(bitcoinListEndpoint), headers: headers);
//     log(json.encode(response.body));
//     if (response.statusCode == 200) {
//       // final Map<String, dynamic> map = jsonDecode(response.body);
//       // final code = map['code'];
//       res = bitcoinListResponseFromJson(response.body);

//       return res;
//     } else {
//       final errorBody = jsonDecode(response.body);
//       final errorMessage = errorBody['error']['message'];

//       throw ServerException(
//         message: errorMessage,
//         statusCode: response.statusCode,
//       );
//     }
//   }
// }

import 'dart:convert';
import 'dart:developer';
import 'package:blockchain_mobile_app/core/constant/api_constants.dart';
import 'package:blockchain_mobile_app/core/exceptions/exceptions.dart';
import 'package:blockchain_mobile_app/core/header_provider/header_provider.dart';
import 'package:blockchain_mobile_app/features/home/data/model/bitcoin_list_response.dart';
import 'package:http/http.dart' as http;

abstract class BitcoinListRemote {
  Future<List<BitcoinListResponse>> bitcoinList();
}

class BitcoinListRemoteImpl implements BitcoinListRemote {
  static const bitcoinListEndpoint =
      ApiConstants.baseCommonApiUrl + ApiConstants.bitcoinList;
  final HeaderProvider _apiHeaderProvider;
  BitcoinListRemoteImpl(this._apiHeaderProvider);

  @override
  Future<List<BitcoinListResponse>> bitcoinList() async {
    final headers = _apiHeaderProvider();
    log("header ::::  ${json.encode(headers)}");

    final response =
        await http.get(Uri.parse(bitcoinListEndpoint), headers: headers);
    // log(json.encode(response.body));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      final List<BitcoinListResponse> resList = List<BitcoinListResponse>.from(
          jsonList.map((json) => BitcoinListResponse.fromJson(json)));

      return resList;
    } else {
      final errorBody = jsonDecode(response.body);
      final errorMessage = errorBody['error']['message'];

      throw ServerException(
        message: errorMessage,
        statusCode: response.statusCode,
      );
    }
  }
}
