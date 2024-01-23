
// import 'package:blockchain_mobile_app/features/home/data/model/bitcoin_list_response.dart';
// import 'package:blockchain_mobile_app/features/home/domain/repository/bitcoin_list_repository.dart';

// class BitcoinListUsecase {
//   final BitcoinListRepository _bitcoinListRepository;

//   BitcoinListUsecase(this._bitcoinListRepository);

//   Future<BitcoinListResponse> call() =>
//       _bitcoinListRepository.bitcoinList();
// }



import 'package:blockchain_mobile_app/features/home/data/model/bitcoin_list_response.dart';
import 'package:blockchain_mobile_app/features/home/domain/repository/bitcoin_list_repository.dart';

class BitcoinListUsecase {
  final BitcoinListRepository _bitcoinListRepository;

  BitcoinListUsecase(this._bitcoinListRepository);

  Future<List<BitcoinListResponse>> call() => _bitcoinListRepository.bitcoinList();
}
