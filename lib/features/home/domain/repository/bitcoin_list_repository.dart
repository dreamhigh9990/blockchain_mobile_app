// import 'package:blockchain_mobile_app/features/home/data/model/bitcoin_list_response.dart';

// abstract class BitcoinListRepository {
//   Future<BitcoinListResponse> bitcoinList();
// }
import 'package:blockchain_mobile_app/features/home/data/model/bitcoin_list_response.dart';

abstract class BitcoinListRepository {
  Future<List<BitcoinListResponse>> bitcoinList();
}
