import 'package:bloc/bloc.dart';
import 'package:blockchain_mobile_app/common/graphql/graphql_services.dart';
import 'package:equatable/equatable.dart';

part 'change_passwod_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final GraphQLService graphqlService;

  ChangePasswordCubit({required this.graphqlService})
      : super(ChangePasswordInitial());

  Future<void> changePassword(
      String oldPassword, String newPassword, String confirmPassword) async {
    emit(ChangePasswordLoading());
    try {
      await graphqlService.changePassword(
          oldPassword, newPassword, confirmPassword);
      emit(ChangePasswordSuccess('Password changed successfully'));
    } catch (error) {
      emit(ChangePasswordFailure('Password change failed: $error'));
    }
  }
}
