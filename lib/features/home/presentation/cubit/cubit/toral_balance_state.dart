part of 'toral_balance_cubit.dart';

abstract class TotalBalanceState extends Equatable {
  const TotalBalanceState();

  @override
  List<Object> get props => [];
}

class TotalBalanceInitial extends TotalBalanceState {}

class TotalBalanceLoading extends TotalBalanceState {}

class TotalBalanceSuccess extends TotalBalanceState {
  final Map<String, dynamic> totalBalance;

  TotalBalanceSuccess(this.totalBalance);

  @override
  List<Object> get props => [totalBalance];
}

class TotalBalanceFailure extends TotalBalanceState {
  final String error;

  TotalBalanceFailure(this.error);

  @override
  List<Object> get props => [error];
}
