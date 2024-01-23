// ignore_for_file: unnecessary_null_comparison

import 'package:bloc/bloc.dart';
import 'package:blockchain_mobile_app/common/graphql/graphql_services.dart';

part 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  final GraphQLService graphqlService;

  UserInfoCubit({required this.graphqlService}) : super(UserInfoInitial());

  Future<void> getUserInfo() async {
    emit(UserInfoLoading());

    try {
      final result = await graphqlService.getUserInfo();

      if (result != null) {
        emit(UserInfoLoaded(result));
      } else {
        emit(UserInfoError('No user info available.'));
      }
    } catch (e) {
      emit(UserInfoError('Error retrieving user info: $e'));
    }
  }
}
