import 'package:counter/models/payment_card_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_new_card_state.dart';

class AddNewCardCubit extends Cubit<AddNewCardState> {
  AddNewCardCubit()
    : super(AddNewCardInitial()); // Start with initial state instead of loading
  String selectedId = dummyPaymentCards.first.id;

  void addNewCardPayemnt(
    String cardNumer,
    String cardHolderName,
    String expiaryDate,
    String ccv,
  ) {
    emit(ConfirmPaymentLoading());
    final newAdd = PaymentCardModel(
      id: DateTime.now().toIso8601String(),
      cardNumber: cardNumer,
      cardHolderName: cardHolderName,
      expiryDate: expiaryDate,
      cvv: ccv,
    );
    dummyPaymentCards.add(newAdd);
    // Properly handle the delayed state change
    Future.delayed(Duration(seconds: 2)).then((_) {
      emit(AddNewCardLoaded());
    });
  }

  void fetchPaymentMethod() {
    emit(FetchingPaymentMethods());
    Future.delayed(Duration(seconds: 2), () {
      if (dummyPaymentCards.isNotEmpty) {
        // final changeChosenRadio = dummyPaymentCards.firstWhere(
        //   (cardItem) => cardItem.isChosen == true,
        //   orElse: () => dummyPaymentCards.first,
        // );
        // emit(ChangeChosenRadio(paymentCards: changeChosenRadio));
        emit(FetchedPaymentMethods(paymentCards: dummyPaymentCards));
      } else {
        emit(FetchPaymentMethodsError(massage: "No payment method found"));
      }
    });
  }

  void changeChosenRadio(String id) {
    // int prevIndex = dummyPaymentCards.indexWhere(
    //   (cardItem) => cardItem.isChosen == true,
    // );
    // int newIndex = dummyPaymentCards.indexWhere(
    //   (cardItem) => cardItem.id == id,
    // );
    // var chosenCard = dummyPaymentCards.firstWhere(
    //   (cardItem) => cardItem.id == id,
    // );
    // var previousChosenCard = dummyPaymentCards.firstWhere(
    //   (cardItem) => cardItem.isChosen == true,
    //   orElse: () => dummyPaymentCards.first,
    // );
    // previousChosenCard = previousChosenCard.copyWith(isChosen: false);
    // chosenCard = chosenCard.copyWith(isChosen: true);
    // dummyPaymentCards[prevIndex] = previousChosenCard;
    // dummyPaymentCards[newIndex] = chosenCard;
    // emit(ChangeChosenRadio(paymentCards: chosenCard));
    selectedId = id;
    int newIndex = dummyPaymentCards.indexWhere(
      (cardItem) => cardItem.id == selectedId,
    );
    var tempChosenCard = dummyPaymentCards[newIndex].copyWith(isChosen: true);
    dummyPaymentCards[newIndex] = tempChosenCard;

    emit(ChangeChosenRadio(paymentCards: tempChosenCard));
  }

  void confirmPayment() {
    emit(ConfirmPaymentLoading());
    Future.delayed(Duration(seconds: 2), () {
      int prevIndex = dummyPaymentCards.indexWhere(
        (cardItem) => cardItem.isChosen == true,
      );

      int newIndex = dummyPaymentCards.indexWhere(
        (cardItem) => cardItem.id == selectedId,
      );

      // اعمل Unselect للقديم لو موجود
      if (prevIndex != -1) {
        var previousChosen = dummyPaymentCards[prevIndex].copyWith(
          isChosen: false,
        );
        dummyPaymentCards[prevIndex] = previousChosen;
      }

      // Select الجديد
      var chosenCard = dummyPaymentCards[newIndex].copyWith(isChosen: true);
      dummyPaymentCards[newIndex] = chosenCard;

      emit(ConfirmPaymentSuccess());
    });
  }
}
