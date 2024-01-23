import 'package:bloc/bloc.dart';
import 'package:blockchain_mobile_app/common/graphql/graphql_services.dart';
import 'package:equatable/equatable.dart';

part 'verify_otp_state.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  final GraphQLService
      graphqlService; // Replace with your actual GraphQL service

  VerifyOtpCubit({required this.graphqlService}) : super(VerifyOtpInitial());

  Future<void> verifyOtp({
    required int id,
    required String model_type,
    required String otp,
  }) async {
    emit(VerifyOtpLoading());
    try {
      final data = await graphqlService.checkOtp(
          id: id, model_type: model_type, otp: otp);

      emit(VerifyOtpSuccess(data));
    } catch (error) {
      emit(VerifyOtpError(error.toString()));
    }
  }
}
