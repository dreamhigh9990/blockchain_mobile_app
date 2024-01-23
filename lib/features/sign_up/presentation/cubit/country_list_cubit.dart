// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:blockchain_mobile_app/common/graphql/graphql_services.dart';
import 'package:equatable/equatable.dart';

part 'country_list_state.dart';

class CountryListCubit extends Cubit<CountryListState> {
  final GraphQLService graphqlService;

  CountryListCubit({required this.graphqlService})
      : super(CountryListInitial());

  Future<void> fetchCountryList() async {
    emit(CountryListLoading());

    try {
      // Call the GraphQL query to fetch the list of countries
      final countryList = await graphqlService.getCountryList();

      if (countryList != null) {
        emit(CountryListSuccess(countryList));
      } else {
        emit(CountryListFailure('Failed to fetch the list of countries'));
      }
    } catch (error) {
      log('Fetching the list of countries failed: $error');
      emit(CountryListFailure('Fetching the list of countries failed: $error'));
    }
  }
}
