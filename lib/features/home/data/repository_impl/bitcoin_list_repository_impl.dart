
// import 'package:blockchain_mobile_app/core/exceptions/exceptions.dart';
// import 'package:blockchain_mobile_app/core/network/connection_checker.dart';
// import 'package:blockchain_mobile_app/features/home/data/model/bitcoin_list_response.dart';
// import 'package:blockchain_mobile_app/features/home/data/remote/bitcoin_list_remote.dart';
// import 'package:blockchain_mobile_app/features/home/domain/repository/bitcoin_list_repository.dart';

// class BitcoinListRepositoryImpl implements BitcoinListRepository {
//   final ConnectionChecker _connectionChecker;
//   final BitcoinListRemote bitcoinListRemote;

//   BitcoinListRepositoryImpl(
//       this._connectionChecker, this.bitcoinListRemote);

//   @override
//   Future<BitcoinListResponse> bitcoinList() async {
//     if (!await _connectionChecker.isConnected()) throw NoInternetException();
//     BitcoinListResponse bitcoinListResponse =
//         await bitcoinListRemote.bitcoinList();
        
//     return bitcoinListResponse;
//   }
// }

import 'package:blockchain_mobile_app/core/exceptions/exceptions.dart';
import 'package:blockchain_mobile_app/core/network/connection_checker.dart';
import 'package:blockchain_mobile_app/features/home/data/model/bitcoin_list_response.dart';
import 'package:blockchain_mobile_app/features/home/data/remote/bitcoin_list_remote.dart';
import 'package:blockchain_mobile_app/features/home/domain/repository/bitcoin_list_repository.dart';

class BitcoinListRepositoryImpl implements BitcoinListRepository {
  final ConnectionChecker _connectionChecker;
  final BitcoinListRemote bitcoinListRemote;

  BitcoinListRepositoryImpl(this._connectionChecker, this.bitcoinListRemote);

  @override
  Future<List<BitcoinListResponse>> bitcoinList() async {
    if (!await _connectionChecker.isConnected()) throw NoInternetException();
    List<BitcoinListResponse> bitcoinListResponse =
        await bitcoinListRemote.bitcoinList();

    return bitcoinListResponse;
  }
}
