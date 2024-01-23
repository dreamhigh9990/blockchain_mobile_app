import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:blockchain_mobile_app/common/graphql/graphql_services.dart';

part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  final GraphQLService graphqlService;

  TransactionsCubit({required this.graphqlService})
      : super(TransactionsInitial());

  Future<void> getTransactions(String walletAddress) async {
    emit(TransactionsLoading());

    try {
      final transactions = await graphqlService.getTransactions(walletAddress);
      emit(TransactionsSuccess(transactions));
    } catch (error) {
      emit(TransactionsFailure('Failed to load transactions: $error'));
    }
  }
}
