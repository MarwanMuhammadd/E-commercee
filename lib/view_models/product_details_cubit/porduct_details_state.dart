part of 'porduct_details_cubit.dart';

sealed class PorductDetailsState {}

final class PorductDetailsInitial extends PorductDetailsState {}

final class ProductDetailsLoading extends PorductDetailsState {}

final class ProductDetailsLoaded extends PorductDetailsState {
  final ProductItemModel product;

  ProductDetailsLoaded({required this.product});
}


final class ProductDetailsError extends PorductDetailsState {
  final String massage;

  ProductDetailsError({required this.massage});
}
final class SizeSelected extends PorductDetailsState{
  final ProductSize size;
  SizeSelected({required this.size});
}

final class QuantityCounterLoaded extends PorductDetailsState {
  final int value;
  //final ProductItemModel product;

  QuantityCounterLoaded({required this.value , });
}
final class ProductAddedToCart extends PorductDetailsState{
  final String productId;

  ProductAddedToCart({required this.productId});

}
final class ProductAddingToCart extends PorductDetailsState{
 

}