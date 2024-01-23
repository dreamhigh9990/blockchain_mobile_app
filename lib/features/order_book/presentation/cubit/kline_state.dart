part of 'kline_cubit.dart';

abstract class KlineState extends Equatable {
  const KlineState();

  @override
  List<Object> get props => [];
}

class KlineInitial extends KlineState {}

class KlineLoading extends KlineState {}

class KlineSuccess extends KlineState {
  // final KlineResponse klineResponse;
  final List<List<dynamic>> klineResponse;
  const KlineSuccess({required this.klineResponse});
}

class KlineFailure extends KlineState {
  final StackTrace stackTrace;

  // final KlineResponse klineResponse;
  final Object exception;

  const KlineFailure(this.exception, this.stackTrace,);
}
