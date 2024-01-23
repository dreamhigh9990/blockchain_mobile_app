part of 'resend_otp_cubit.dart';

sealed class ResendOtpState extends Equatable {
  const ResendOtpState();

  @override
  List<Object> get props => [];
}

class ResendOtpInitial extends ResendOtpState {}

class ResendOtpLoading extends ResendOtpState {}

class ResendOtpSuccess extends ResendOtpState {
  final Map<String, dynamic> otpResendResponse;

  ResendOtpSuccess(this.otpResendResponse);
}

class ResendOtpError extends ResendOtpState {
  final String errorMessage;

  ResendOtpError(this.errorMessage);
}
