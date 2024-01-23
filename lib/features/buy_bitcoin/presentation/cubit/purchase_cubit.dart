import 'package:bloc/bloc.dart';
import 'package:blockchain_mobile_app/common/graphql/graphql_services.dart';
import 'package:equatable/equatable.dart';

part 'purchase_state.dart';

class PurchaseCubit extends Cubit<PurchaseState> {
  final GraphQLService graphqlService;

  PurchaseCubit({required this.graphqlService}) : super(PurchaseInitial());

  Future<void> purchase({
    required String senderWalletAddress,
    required String cryptocurrencySymbol,
    required double cryptocurrencyAmount,
    required String receiverWalletAddress,
    required double amount,
    required String currencyType,
  }) async {
    emit(PurchaseLoading());

    try {
      final purchaseResponse = await graphqlService.purchase(
        senderWalletAddress: senderWalletAddress,
        cryptocurrencySymbol: cryptocurrencySymbol,
        cryptocurrencyAmount: cryptocurrencyAmount,
        receiverWalletAddress: receiverWalletAddress,
        amount: amount,
        currencyType: currencyType,
      );

      if (purchaseResponse != null) {
        emit(PurchaseSuccess(purchaseResponse['message']));
      } else {
        emit(PurchaseFailure('Failed to complete purchase'));
      }
    } catch (error) {
      emit(PurchaseFailure('Purchase operation failed: $error'));
    }
  }
}
