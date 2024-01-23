part of 'verify_otp_cubit.dart';

abstract class VerifyOtpState extends Equatable {
  const VerifyOtpState();

  @override
  List<Object> get props => [];
}

class VerifyOtpInitial extends VerifyOtpState {}

class VerifyOtpLoading extends VerifyOtpState {}

class VerifyOtpSuccess extends VerifyOtpState {
  final String message;

  VerifyOtpSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class VerifyOtpError extends VerifyOtpState {
  final String errorMessage;

  VerifyOtpError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
