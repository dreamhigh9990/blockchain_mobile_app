import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:blockchain_mobile_app/features/home/data/model/bitcoin_list_response.dart';
import 'package:blockchain_mobile_app/features/home/domain/usecase/bitcoin_list_usecase.dart';
import 'package:equatable/equatable.dart';
part 'bitcoin_list_state.dart';

class BitcoinListCubit extends Cubit<BitcoinListState> {
  final BitcoinListUsecase bitcoinListUsecase;
  BitcoinListCubit({required this.bitcoinListUsecase})
      : super(BitcoinListInitial());

  Future<void> bitcoinList() async {
    try {
      log('try');
      emit(BitcoinListLoading());
      final responseModel = await bitcoinListUsecase();
      emit(BitcoinListSuccess(bitcoinListResponse: responseModel));
    } catch (ex, stackTrace) {
      emit(BitcoinListFailure(ex, stackTrace));
    }
  }
}
