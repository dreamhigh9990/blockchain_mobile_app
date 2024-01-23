part of 'wallet_price_cubit.dart';

abstract class WalletPriceState extends Equatable {
  const WalletPriceState();

  @override
  List<Object?> get props => [];
}

class WalletPriceInitial extends WalletPriceState {}

class WalletPriceLoading extends WalletPriceState {}

class WalletPriceSuccess extends WalletPriceState {
  final Map<String, dynamic> walletBalance;

  const WalletPriceSuccess(this.walletBalance);

  @override
  List<Object?> get props => [walletBalance];
}

class WalletPriceFailure extends WalletPriceState {
  final String error;

  const WalletPriceFailure(this.error);

  @override
  List<Object?> get props => [error];
}
