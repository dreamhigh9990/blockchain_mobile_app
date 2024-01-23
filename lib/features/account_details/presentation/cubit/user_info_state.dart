part of 'user_info_cubit.dart';

abstract class UserInfoState {}

class UserInfoInitial extends UserInfoState {}

class UserInfoLoading extends UserInfoState {}

class UserInfoLoaded extends UserInfoState {
  final Map<String, dynamic> userInfo;

  UserInfoLoaded(this.userInfo);
}

class UserInfoError extends UserInfoState {
  final String errorMessage;

  UserInfoError(this.errorMessage);
}
