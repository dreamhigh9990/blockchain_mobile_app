import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:blockchain_mobile_app/features/order_book/domain/usecase/kline_usecase.dart';
import 'package:equatable/equatable.dart';
part 'kline_state.dart';

class KlineCubit extends Cubit<KlineState> {
  final KlineUsecase klineUsecase;
  KlineCubit({required this.klineUsecase}) : super(KlineInitial());

  Future<void> kline(String symbol, String interval, String limit) async {
    try {
      log('try');
      emit(KlineLoading());
      final responseModel = await klineUsecase(symbol,interval,limit);
      emit(KlineSuccess(klineResponse: responseModel));
    } catch (ex, stackTrace) {
      emit(KlineFailure(ex, stackTrace));
    }
  }
}
