import 'package:bloc/bloc.dart';
import 'package:blockchain_mobile_app/common/graphql/graphql_services.dart';
import 'package:equatable/equatable.dart';

part 'resend_otp_state.dart';

class ResendOtpCubit extends Cubit<ResendOtpState> {
  final GraphQLService graphqlService;

  ResendOtpCubit({required this.graphqlService}) : super(ResendOtpInitial());

  Future<void> resendOtp({
    required String email,
  }) async {
    emit(ResendOtpLoading());

    try {
      final otpResendResponse = await graphqlService.resendOtp(email: email);

      emit(ResendOtpSuccess(otpResendResponse));
    } catch (error) {
      emit(ResendOtpError(error.toString()));
    }
  }
}
