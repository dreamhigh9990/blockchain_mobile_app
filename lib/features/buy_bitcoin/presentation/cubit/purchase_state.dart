part of 'purchase_cubit.dart';

abstract class PurchaseState extends Equatable {
  const PurchaseState();

  @override
  List<Object> get props => [];
}

class PurchaseInitial extends PurchaseState {}

class PurchaseLoading extends PurchaseState {}

class PurchaseSuccess extends PurchaseState {
  final String message;

  PurchaseSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class PurchaseFailure extends PurchaseState {
  final String error;

  PurchaseFailure(this.error);

  @override
  List<Object> get props => [error];
}
