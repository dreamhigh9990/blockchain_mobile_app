import 'package:bloc/bloc.dart';
import 'package:blockchain_mobile_app/common/graphql/graphql_services.dart';
import 'package:equatable/equatable.dart';

part 'update_user_state.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  final GraphQLService graphqlService;

  UpdateUserCubit({required this.graphqlService}) : super(UpdateUserInitial());

  void updateUser({
    required String name,
    required String phone,
    required String countryId,
    required String callingCode,
    required String address,
  }) async {
    emit(UpdateUserLoading());
    try {
      final message = await graphqlService.updateUser(
        name: name,
        phone: phone,
        countryId: countryId,
        callingCode: callingCode,
        address: address,
      );
      emit(UpdateUserSuccess(message));
    } catch (error) {
      emit(UpdateUserFailure(error.toString()));
    }
  }
}
