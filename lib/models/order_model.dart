import 'package:counter/models/product_item_model.dart';

class addToCartModel {
  final String uniqueId;
  final ProductItemModel product;
  final ProductSize sizeProduct;
  final int quentity;

  addToCartModel({
    required this.uniqueId,
    required this.product,
    required this.sizeProduct,
    required this.quentity,
  });
  int get totalPrice{
    return product.price * quentity;
  }
  addToCartModel copyWith({
    String? uniqueId,
    ProductItemModel? product,
    ProductSize? sizeProduct,
    int? quentity,
  }) {
    return addToCartModel(
      uniqueId: uniqueId ?? this.uniqueId,
      product: product ?? this.product,
      sizeProduct: sizeProduct ?? this.sizeProduct,
      quentity: quentity ?? this.quentity,
    );
  }
}
List<addToCartModel>dummyCart=[];
