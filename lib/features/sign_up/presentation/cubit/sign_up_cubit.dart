import 'package:bloc/bloc.dart';
import 'package:blockchain_mobile_app/common/graphql/graphql_services.dart';
import 'package:equatable/equatable.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final GraphQLService graphqlService;

  SignUpCubit({required this.graphqlService}) : super(SignUpInitial());

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
    int? country_id,
    String ? referral_code,
    required String calling_code,
  }) async {
    emit(SignUpLoading());

    try {
      final userData = await graphqlService.signUp(
        name: name,
        email: email,
        password: password,
        phone: phone,
        country_id: country_id,
        calling_code: calling_code,
        referral_code: referral_code,
      );

      emit(SignUpSuccess(userData));
    } catch (error) {
      emit(SignUpError(error.toString()));
    }
  }
}
