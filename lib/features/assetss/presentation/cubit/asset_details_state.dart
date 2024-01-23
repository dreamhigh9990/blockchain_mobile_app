part of 'asset_details_cubit.dart';

abstract class AssetDetailsState extends Equatable {
  const AssetDetailsState();

  @override
  List<Object> get props => [];
}

class AssetDetailsInitial extends AssetDetailsState {}

class AssetDetailsLoading extends AssetDetailsState {}

class AssetDetailsSuccess extends AssetDetailsState {
  final AssetDetailsResponse assetDetailsResponse;
  const AssetDetailsSuccess({required this.assetDetailsResponse});
}

class AssetDetailsFailure extends AssetDetailsState {
  final StackTrace stackTrace;

  // final AssetDetailsResponse assetDetailsResponse;
  final Object exception;

  const AssetDetailsFailure(
    this.exception,
    this.stackTrace,
  );
}
