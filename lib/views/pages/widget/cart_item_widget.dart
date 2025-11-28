import 'package:counter/models/order_model.dart';
import 'package:counter/utlis/app_color.dart';
import 'package:counter/view_models/cart_cubit/cart_cubit.dart';
import 'package:counter/views/pages/widget/counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hash_cached_image/hash_cached_image.dart';

class CartItemWidget extends StatelessWidget {
  final addToCartModel cartItems;
  const CartItemWidget({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.greyShade,
              borderRadius: BorderRadius.circular(16),
            ),
            child: HashCachedImage(
              imageUrl: cartItems.product.imgUrl,
              height: 100,
              width: 100,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cartItems.product.name),
                Text.rich(
                  TextSpan(
                    text: "Size :",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(color: AppColors.grey),
                    children: [
                      TextSpan(
                        text: (cartItems.sizeProduct.name).toString(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<CartCubit, CartState>(
                      buildWhen:
                          (previous, current) =>
                              current is QuantityCounterLoaded &&
                              current.productId == cartItems.product.id,
                      bloc: BlocProvider.of<CartCubit>(context),
                      builder: (context, state) {
                        if (state is QuantityCounterLoaded) {
                          return CounterWidget(
                            value: state.value,
                            productId: cartItems.product.id,
                            cubit: BlocProvider.of<CartCubit>(context),
                          );
                        } else {
                          return CounterWidget(
                            value: cartItems.quentity,
                            productId: cartItems.product.id,
                            cubit: BlocProvider.of<CartCubit>(context),
                            initialValue: cartItems.quentity,
                          );
                        }
                      },
                    ),
                    Text(
                      "\$${(cartItems.totalPrice).toString()}",
                      style: Theme.of(context).textTheme.headlineMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
