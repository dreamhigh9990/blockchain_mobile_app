

import 'package:blockchain_mobile_app/features/assetss/data/model/asset_details_response.dart';

abstract class AssetDetailsRepository {
  Future<AssetDetailsResponse> assetDetails(String symbol);
}
