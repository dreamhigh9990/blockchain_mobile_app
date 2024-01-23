part of 'bitcoin_list_cubit.dart';

abstract class BitcoinListState extends Equatable {
  const BitcoinListState();

  @override
  List<Object> get props => [];
}

class BitcoinListInitial extends BitcoinListState {}

class BitcoinListLoading extends BitcoinListState {}

class BitcoinListSuccess extends BitcoinListState {
  // final BitcoinListResponse bitcoinListResponse;
  final List<BitcoinListResponse> bitcoinListResponse;
  const BitcoinListSuccess({required this.bitcoinListResponse});
}

class BitcoinListFailure extends BitcoinListState {
  final StackTrace stackTrace;

  // final BitcoinListResponse bitcoinListResponse;
  final Object exception;

  const BitcoinListFailure(this.exception, this.stackTrace,);
}
