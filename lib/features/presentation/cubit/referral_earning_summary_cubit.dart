import 'package:bloc/bloc.dart';
import 'package:blockchain_mobile_app/common/graphql/graphql_services.dart';
import 'package:equatable/equatable.dart';

part 'referral_earning_summary_state.dart';

class ReferralEarningSummaryCubit extends Cubit<ReferralEarningSummaryState> {
  final GraphQLService graphqlService;

  ReferralEarningSummaryCubit({required this.graphqlService})
      : super(ReferralEarningSummaryInitial());

  Future<void> getReferralEarningSummary() async {
    emit(ReferralEarningSummaryLoading());

    try {
      final referralEarningSummary =
          await graphqlService.getReferralEarningSummary();

      emit(ReferralEarningSummarySuccess(referralEarningSummary));
    } catch (error) {
      emit(ReferralEarningSummaryFailure(error.toString()));
    }
  }
}
