part of 'currency_list_cubit.dart';

sealed class CurrencyListState extends Equatable {
  const CurrencyListState();

  @override
  List<Object> get props => [];
}

final class CurrencyListInitial extends CurrencyListState {}
class CurrencyListLoading extends CurrencyListState {}

class CurrencyListSuccess extends CurrencyListState {
  final List<Map<String, dynamic>> currencyList;

  CurrencyListSuccess(this.currencyList);

  @override
  List<Object> get props => [currencyList];
}

class CurrencyListFailure extends CurrencyListState {
  final String error;

  CurrencyListFailure(this.error);

  @override
  List<Object> get props => [error];
}
