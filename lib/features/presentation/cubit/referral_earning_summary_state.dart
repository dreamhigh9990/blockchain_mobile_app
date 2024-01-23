part of 'referral_earning_summary_cubit.dart';
abstract class ReferralEarningSummaryState extends Equatable {
  const ReferralEarningSummaryState();

  @override
  List<Object> get props => [];
}

class ReferralEarningSummaryInitial extends ReferralEarningSummaryState {}

class ReferralEarningSummaryLoading extends ReferralEarningSummaryState {}

class ReferralEarningSummarySuccess extends ReferralEarningSummaryState {
  final Map<String, dynamic> referralEarningSummary;

  ReferralEarningSummarySuccess(this.referralEarningSummary);

  @override
  List<Object> get props => [referralEarningSummary];
}

class ReferralEarningSummaryFailure extends ReferralEarningSummaryState {
  final String error;

  ReferralEarningSummaryFailure(this.error);

  @override
  List<Object> get props => [error];
}
