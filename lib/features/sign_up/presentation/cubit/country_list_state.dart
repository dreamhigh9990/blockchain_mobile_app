part of 'country_list_cubit.dart';

sealed class CountryListState extends Equatable {
  const CountryListState();

  @override
  List<Object> get props => [];
}

final class CountryListInitial extends CountryListState {}
class CountryListLoading extends CountryListState {}

class CountryListSuccess extends CountryListState {
  final List<Map<String, dynamic>> countryList;

  CountryListSuccess(this.countryList);

  @override
  List<Object> get props => [countryList];
}

class CountryListFailure extends CountryListState {
  final String error;

  CountryListFailure(this.error);

  @override
  List<Object> get props => [error];
}
