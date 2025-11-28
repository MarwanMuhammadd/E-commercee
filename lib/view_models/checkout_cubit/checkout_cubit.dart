import 'package:counter/models/order_model.dart';
import 'package:counter/models/payment_card_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());
  void getCheckOutData() {
    emit(CheckoutLoading());
    Future.delayed(Duration(seconds: 2), () {
      final cartItem = dummyCart;
      final subTotal = cartItem.fold<int>(
        0,
        (prev, item) => prev + (item.product.price * item.quentity),
      );
      final numOfProduct = cartItem.fold<int>(
        0,
        (prev, item) => prev + item.quentity,
      );
      final PaymentCardModel? chosenPaymentCards = dummyPaymentCards.isNotEmpty
          ? dummyPaymentCards.firstWhere(
              (c) => c.isChosen,
              orElse: () => dummyPaymentCards.last,
            )
          : null;
      emit(
        CheckoutLoaded(
          cartItems: cartItem,
          subTotal: subTotal,
          numberOfProduct: numOfProduct,
          chosenPaymentCards: chosenPaymentCards,
        ),
      );
    });
  }
  
}
