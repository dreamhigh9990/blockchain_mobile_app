import 'package:bloc/bloc.dart';
import 'package:blockchain_mobile_app/common/graphql/graphql_services.dart';
import 'package:equatable/equatable.dart';

part 'toral_balance_state.dart';

class TotalBalanceCubit extends Cubit<TotalBalanceState> {
  final GraphQLService graphqlService;

  TotalBalanceCubit({required this.graphqlService})
      : super(TotalBalanceInitial());

  Future<void> getTotalBalance() async {
    emit(TotalBalanceLoading());

    try {
      final totalBalance = await graphqlService.getTotalBalance();

      emit(TotalBalanceSuccess(totalBalance!));
    } catch (error) {
      emit(TotalBalanceFailure(error.toString()));
    }
  }
}
