part of 'add_new_card_cubit.dart';

sealed class AddNewCardState {}

final class AddNewCardInitial extends AddNewCardState {}

final class AddNewCardloading extends AddNewCardState {}

final class AddNewCardLoaded extends AddNewCardState {}

final class AddNewCardfailure extends AddNewCardState {
  final String massage;

  AddNewCardfailure({required this.massage});
}

final class FetchingPaymentMethods extends AddNewCardState {}

final class FetchedPaymentMethods extends AddNewCardState {
  final List<PaymentCardModel> paymentCards;

  FetchedPaymentMethods({required this.paymentCards});
}

final class FetchPaymentMethodsError extends AddNewCardState {
  final String massage;

  FetchPaymentMethodsError({required this.massage});
}

final class ChangeChosenRadio extends AddNewCardState {
  final PaymentCardModel paymentCards;

  ChangeChosenRadio({required this.paymentCards});
}

final class ConfirmPaymentLoading extends AddNewCardState {}

final class ConfirmPaymentSuccess extends AddNewCardState {}

final class ConfirmPaymentFailure extends AddNewCardState {
  final String massage;

  ConfirmPaymentFailure({required this.massage});
}
