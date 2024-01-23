part of 'update_user_cubit.dart';

abstract class UpdateUserState extends Equatable {
  const UpdateUserState();

  @override
  List<Object> get props => [];
}

class UpdateUserInitial extends UpdateUserState {}

class UpdateUserLoading extends UpdateUserState {}

class UpdateUserSuccess extends UpdateUserState {
  final String message;

  UpdateUserSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class UpdateUserFailure extends UpdateUserState {
  final String error;

  UpdateUserFailure(this.error);

  @override
  List<Object> get props => [error];
}
