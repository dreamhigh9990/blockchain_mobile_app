import 'package:bloc/bloc.dart';
import 'package:blockchain_mobile_app/common/graphql/graphql_services.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final GraphQLService graphqlService;

  LoginCubit({required this.graphqlService}) : super(LoginInitial());

  Future<void> login({
    required String email,
    required String password,
    required String device,
  }) async {
    emit(LoginLoading());

    try {
      final loginResponse = await graphqlService.login(
        email: email,
        password: password,
        device: device,
      );

      emit(LoginSuccess(loginResponse));
    } catch (error) {
      emit(LoginError(error.toString()));
    }
  }
}
