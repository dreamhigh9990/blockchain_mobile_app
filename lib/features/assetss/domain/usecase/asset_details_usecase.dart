
import 'package:blockchain_mobile_app/features/assetss/data/model/asset_details_response.dart';
import 'package:blockchain_mobile_app/features/assetss/domain/repository/asset_details_repository.dart';

class AssetDetailsUsecase {
  final AssetDetailsRepository _assetDetailsRepository;

  AssetDetailsUsecase(this._assetDetailsRepository);

  Future<AssetDetailsResponse> call(String symbol) =>
      _assetDetailsRepository.assetDetails(symbol);
}
