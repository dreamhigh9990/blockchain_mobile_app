// ignore_for_file: unnecessary_null_comparison

import 'package:bloc/bloc.dart';
import 'package:blockchain_mobile_app/common/graphql/graphql_services.dart';
import 'package:equatable/equatable.dart';

part 'wallet_price_state.dart';

class WalletPriceCubit extends Cubit<WalletPriceState> {
  final GraphQLService graphQLService;

  WalletPriceCubit({required this.graphQLService})
      : super(WalletPriceInitial());

  Future<void> getWalletPrice(String symbol) async {
    emit(WalletPriceLoading());

    try {
      final result = await graphQLService.getWalletBalanceInfo(symbol);

      if (result != null) {
        emit(WalletPriceSuccess(result));
      } else {
        emit(WalletPriceFailure('Failed to get wallet balance'));
      }
    } catch (error) {
      emit(WalletPriceFailure('Error: $error'));
    }
  }
}
