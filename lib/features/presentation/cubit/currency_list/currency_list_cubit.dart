// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:blockchain_mobile_app/common/graphql/graphql_services.dart';
import 'package:equatable/equatable.dart';

part 'currency_list_state.dart';

class CurrencyListCubit extends Cubit<CurrencyListState> {
  final GraphQLService graphqlService;

  CurrencyListCubit({required this.graphqlService})
      : super(CurrencyListInitial());

  Future<void> fetchCurrencyList() async {
    emit(CurrencyListLoading());

    try {
      // Call the GraphQL query to fetch the list of countries
      final currencyList = await graphqlService.getCurrencyList();

      if (currencyList != null) {
        emit(CurrencyListSuccess(currencyList));
      } else {
        emit(CurrencyListFailure('Failed to fetch the list of countries'));
      }
    } catch (error) {
      log('Fetching the list of countries failed: $error');
      emit(
          CurrencyListFailure('Fetching the list of countries failed: $error'));
    }
  }
}
