// import 'package:blockchain_mobile_app/features/home/data/model/bitcoin_list_response.dart';

// abstract class KlineRepository {
//   Future<KlineResponse> kline();
// }

abstract class KlineRepository {
  Future<List<List<dynamic>>> kline(
      String symbol, String interval, String limit);
}
