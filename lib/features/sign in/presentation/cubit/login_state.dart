part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final Map<String, dynamic> loginResponse;

  LoginSuccess(this.loginResponse);
}

class LoginError extends LoginState {
  final String errorMessage;

  LoginError(this.errorMessage);
}
