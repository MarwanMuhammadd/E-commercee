part of 'cart_cubit.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final List<addToCartModel>cartItems;
  final double subTotal;

  CartLoaded({required this.cartItems, required this.subTotal});
}

final class CartError extends CartState {
  final String massage;

  CartError({required this.massage});

}
final class QuantityCounterLoaded extends CartState{
  final int value;
  final String productId;

  QuantityCounterLoaded({required this.value,required this.productId});

}
