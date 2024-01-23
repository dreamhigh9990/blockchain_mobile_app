// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:blockchain_mobile_app/core/constant/api_constants.dart';
import 'package:blockchain_mobile_app/core/exceptions/exceptions.dart';
import 'package:blockchain_mobile_app/core/header_provider/header_provider.dart';
import 'package:blockchain_mobile_app/features/assetss/data/model/asset_details_response.dart';
import 'package:http/http.dart' as http;

abstract class AssetDetailsRemote {
  Future<AssetDetailsResponse> assetDetails(String symbol);
}

class AssetDetailsRemoteImpl implements AssetDetailsRemote {
  final HeaderProvider _apiHeaderProvider;
  AssetDetailsRemoteImpl(this._apiHeaderProvider);

  @override
  Future<AssetDetailsResponse> assetDetails(String symbol) async {
    var assetDetailsEndpoint = ApiConstants.baseCommonApiUrl +
        ApiConstants.bitcoinListforAssetDetails +
        '?symbol=' "$symbol";

    log("assetDetailsEndpoint:$assetDetailsEndpoint");
    AssetDetailsResponse res;
    final headers = _apiHeaderProvider();
    log("header ::::  ${json.encode(headers)}");

    final response =
        await http.get(Uri.parse(assetDetailsEndpoint), headers: headers);
    log(json.encode(response.body));
    if (response.statusCode == 200) {
      res = assetDetailsResponseFromJson(response.body);
      return res;
    } else {
      print("in error");
      final errorBody = jsonDecode(response.body);
      final errorMessage = errorBody['error']['message'];
      log("errorMessage ::::  ${json.encode(errorMessage)}");

      throw ServerException(
        message: errorMessage,
        statusCode: response.statusCode,
      );
    }
  }
}
