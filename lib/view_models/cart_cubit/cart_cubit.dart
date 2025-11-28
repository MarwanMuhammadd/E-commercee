import 'package:counter/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  int quentity = 1;
  void getCartData() {
    emit(CartLoading());
    Future.delayed(Duration(seconds: 2), () {
      final subTotal = dummyCart.fold<double>(
        0,
        (previous, item) => previous + (item.product.price) * item.quentity,
      );
      emit(CartLoaded(cartItems: dummyCart, subTotal: subTotal));
    });
  }

  void increment(String productId,) {
    final currentState = state as CartLoaded;
    final updatedItems =
        currentState.cartItems.map((item) {
          if (item.product.id == productId) {
            return item.copyWith(quentity: item.quentity + 1);
          }
          return item;
        }).toList();
    final subTotal = updatedItems.fold<double>(
      0,
      (previous, item) => previous + (item.product.price) * item.quentity,
    );

    emit(CartLoaded(cartItems: updatedItems, subTotal: subTotal));
  }

  void decrement(String productId,) {
    final currentState = state as CartLoaded;
    final updatedItems =
        currentState.cartItems.map((item) {
          if (item.product.id == productId) {
            return item.copyWith(quentity: item.quentity - 1);
          }
          return item;
        }).toList();
    final subTotal = updatedItems.fold<double>(
      0,
      (previous, item) => previous + (item.product.price) * item.quentity,
    );

    emit(CartLoaded(cartItems: updatedItems, subTotal: subTotal));
  }

  // // ignore: prefer_function_declarations_over_variables
  // void x(String productId) {
  //   final current = state as CartLoaded;
  //   final updated =
  //       current.cartItems.map((element) {
  //         if (element.product.id == productId) {
  //           return element.copyWith(quentity: element.quentity + 1);
  //         }
  //         return element;
  //       }).toList();
  //   final subTotal = updated.fold<double>(
  //     0,
  //     (prev, element) => prev + element.product.price,
  //   );

  //   emit(CartLoaded(cartItems: updated, subTotal: subTotal));
  // }
}
