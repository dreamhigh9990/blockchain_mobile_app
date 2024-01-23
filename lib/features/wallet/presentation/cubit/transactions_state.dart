part of 'transactions_cubit.dart';


abstract class TransactionsState extends Equatable {
  const TransactionsState();

  @override
  List<Object> get props => [];
}

class TransactionsInitial extends TransactionsState {}

class TransactionsLoading extends TransactionsState {}

class TransactionsSuccess extends TransactionsState {
  final List<Map<String, dynamic>>? transactions;

  TransactionsSuccess(this.transactions);

  @override
  List<Object> get props => [transactions!];
}

class TransactionsFailure extends TransactionsState {
  final String error;

  TransactionsFailure(this.error);

  @override
  List<Object> get props => [error];
}
