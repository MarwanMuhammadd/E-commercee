import 'package:counter/utlis/app_color.dart';
import 'package:counter/utlis/app_routes.dart';
import 'package:counter/view_models/cart_cubit/cart_cubit.dart';
import 'package:counter/views/pages/widget/cart_item_widget.dart';
import 'package:counter/views/pages/widget/sub_shipping_total.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return
    // appBar: AppBar(),
    BlocBuilder<CartCubit, CartState>(
      bloc: BlocProvider.of<CartCubit>(context),
      buildWhen:
          (previous, current) =>
              current is CartLoading ||
              current is CartLoaded ||
              current is CartError,
      builder: (context, state) {
        if (state is CartLoading) {
          return Center(child: CircularProgressIndicator.adaptive());
        } else if (state is CartLoaded) {
          final cartItems = state.cartItems;

          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartItems[index];
                    return CartItemWidget(cartItems: cartItem);
                  },
                  separatorBuilder:
                      (context, index) => Divider(color: AppColors.greyShade),
                ),
                SizedBox(height: 16),
                SubShippingTotal(title: "Subtotal", amount: state.subTotal),
                SubShippingTotal(title: "Shipping", amount: 10),
                Dash(
                  dashColor: AppColors.grey,
                  length: MediaQuery.of(context).size.width - 32,
                  dashLength: 6,
                ),

                SubShippingTotal(title: "Total", amount: state.subTotal + 10),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.all(8.0),

                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(
                          context,
                          rootNavigator: true,
                        ).pushNamed(AppRoutes.checkoutRoute);
                      },
                      child: Text("Proceed to Checkout"),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is CartError) {
          return Center(child: Text(state.massage));
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
