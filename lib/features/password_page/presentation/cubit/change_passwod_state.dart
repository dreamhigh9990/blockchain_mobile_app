part of 'change_passwod_cubit.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {
  final String message;

  ChangePasswordSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class ChangePasswordFailure extends ChangePasswordState {
  final String error;

  ChangePasswordFailure(this.error);

  @override
  List<Object> get props => [error];
}
