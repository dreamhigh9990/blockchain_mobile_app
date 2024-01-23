import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:blockchain_mobile_app/features/assetss/data/model/asset_details_response.dart';
import 'package:blockchain_mobile_app/features/assetss/domain/usecase/asset_details_usecase.dart';
import 'package:equatable/equatable.dart';

part 'asset_details_state.dart';

class AssetDetailsCubit extends Cubit<AssetDetailsState> {
  final AssetDetailsUsecase assetDetailsUsecase;
  AssetDetailsCubit({required this.assetDetailsUsecase})
      : super(AssetDetailsInitial());

  Future<void> assetDetails(String symbol) async {
    try {
      log('try');
      emit(AssetDetailsLoading());
      final responseModel = await assetDetailsUsecase(symbol);
      emit(AssetDetailsSuccess(
          assetDetailsResponse: responseModel));
    } catch (ex, stackTrace) {
      print(ex);
      emit(AssetDetailsFailure(ex, stackTrace));
    }
  }
}
