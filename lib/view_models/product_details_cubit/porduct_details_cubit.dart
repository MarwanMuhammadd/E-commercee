import 'package:counter/models/order_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:counter/models/product_item_model.dart';

part 'porduct_details_state.dart';

class PorductDetailsCubit extends Cubit<PorductDetailsState> {
  PorductDetailsCubit() : super(PorductDetailsInitial());
  ProductSize? Size;
  int quentity = 1;

  void getProductDetailsData(String id) {
    emit(ProductDetailsLoading());
    Future.delayed(Duration(seconds: 2), () {
      final selected = dummyProductItem.firstWhere(
        (element) => element.id == id,
      );
      emit(ProductDetailsLoaded(product: selected));
    });
  }

  void increment(String productId) {
    quentity++;
    emit(QuantityCounterLoaded(value: quentity));
  }

  void decrement(String productId) {
    if (quentity > 1) {
      quentity--;
      emit(QuantityCounterLoaded(value: quentity));
    }
  }

  void selectedSize(ProductSize sizeProduct) {
    Size = sizeProduct;
    emit(SizeSelected(size: sizeProduct));
  }

  void addToCard(String productId) {
    emit(ProductAddingToCart());
    final cartItem = addToCartModel(
      product: dummyProductItem.firstWhere(
        (element) => element.id == productId,
      ),
      uniqueId: DateTime.now().toIso8601String(),
      sizeProduct: Size!,
      quentity: quentity,
    );

    dummyCart.add(cartItem);
    Future.delayed(Duration(seconds: 2));
    emit(ProductAddedToCart(productId: productId));
  }
}
