// import 'package:blockchain_mobile_app/core/exceptions/exceptions.dart';
// import 'package:blockchain_mobile_app/core/network/connection_checker.dart';
// import 'package:blockchain_mobile_app/features/home/data/model/bitcoin_list_response.dart';
// import 'package:blockchain_mobile_app/features/home/data/remote/bitcoin_list_remote.dart';
// import 'package:blockchain_mobile_app/features/home/domain/repository/bitcoin_list_repository.dart';

// class KlineRepositoryImpl implements KlineRepository {
//   final ConnectionChecker _connectionChecker;
//   final KlineRemote klineRemote;

//   KlineRepositoryImpl(
//       this._connectionChecker, this.klineRemote);

//   @override
//   Future<KlineResponse> kline() async {
//     if (!await _connectionChecker.isConnected()) throw NoInternetException();
//     KlineResponse klineResponse =
//         await klineRemote.kline();

//     return klineResponse;
//   }
// }

import 'package:blockchain_mobile_app/core/exceptions/exceptions.dart';
import 'package:blockchain_mobile_app/core/network/connection_checker.dart';
import 'package:blockchain_mobile_app/features/order_book/data/remote/kline_book_remote.dart';
import 'package:blockchain_mobile_app/features/order_book/domain/repository/kline_repository.dart';

class KlineRepositoryImpl implements KlineRepository {
  final ConnectionChecker _connectionChecker;
  final KlineRemote klineRemote;

  KlineRepositoryImpl(this._connectionChecker, this.klineRemote);

  @override
  Future<List<List<dynamic>>> kline(
      String symbol, String interval, String limit) async {
    if (!await _connectionChecker.isConnected()) throw NoInternetException();
    List<List<dynamic>> klineResponse =
        await klineRemote.kline(symbol, interval, limit);

    return klineResponse;
  }
}
