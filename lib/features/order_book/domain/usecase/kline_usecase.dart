// import 'package:blockchain_mobile_app/features/home/data/model/bitcoin_list_response.dart';
// import 'package:blockchain_mobile_app/features/home/domain/repository/bitcoin_list_repository.dart';

// class KlineUsecase {
//   final KlineRepository _klineRepository;

//   KlineUsecase(this._klineRepository);

//   Future<KlineResponse> call() =>
//       _klineRepository.kline();
// }

import 'package:blockchain_mobile_app/features/order_book/domain/repository/kline_repository.dart';

class KlineUsecase {
  final KlineRepository _klineRepository;

  KlineUsecase(this._klineRepository);

  Future<List<List<dynamic>>> call(
          String symbol, String interval, String limit) =>
      _klineRepository.kline(symbol, interval, limit);
}
