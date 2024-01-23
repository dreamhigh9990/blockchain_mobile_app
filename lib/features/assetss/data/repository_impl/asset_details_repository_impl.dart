
import 'package:blockchain_mobile_app/core/exceptions/exceptions.dart';
import 'package:blockchain_mobile_app/core/network/connection_checker.dart';
import 'package:blockchain_mobile_app/features/assetss/data/model/asset_details_response.dart';
import 'package:blockchain_mobile_app/features/assetss/data/remote/asset_details_remote.dart';
import 'package:blockchain_mobile_app/features/assetss/domain/repository/asset_details_repository.dart';

class AssetDetailsRepositoryImpl implements AssetDetailsRepository {
  final ConnectionChecker _connectionChecker;
  final AssetDetailsRemote assetDetailsRemote;

  AssetDetailsRepositoryImpl(this._connectionChecker, this.assetDetailsRemote);

  @override
  Future<AssetDetailsResponse> assetDetails(String symbol) async {
    if (!await _connectionChecker.isConnected()) throw NoInternetException();
    AssetDetailsResponse assetDetailsResponse =
        await assetDetailsRemote.assetDetails(symbol);

    return assetDetailsResponse;
  }
}
