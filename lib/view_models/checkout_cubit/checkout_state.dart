part of 'checkout_cubit.dart';

sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class CheckoutLoading extends CheckoutState {}

final class CheckoutLoaded extends CheckoutState {
  final List<addToCartModel> cartItems;
  final int subTotal;
  final int numberOfProduct;
  final PaymentCardModel? chosenPaymentCards;

  CheckoutLoaded({
    required this.cartItems,
    required this.subTotal,
    required this.numberOfProduct,
     this.chosenPaymentCards,
  });
}

final class CheckoutError extends CheckoutState {
  final String error;

  CheckoutError({required this.error});
}
