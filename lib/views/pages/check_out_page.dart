import 'package:counter/models/payment_card_model.dart';
import 'package:counter/utlis/app_color.dart';
import 'package:counter/view_models/add_new_card_cubit/add_new_card_cubit.dart';
import 'package:counter/view_models/checkout_cubit/checkout_cubit.dart';
import 'package:counter/views/pages/widget/address_and_payment.dart';
import 'package:counter/views/pages/widget/checkout_headline_item.dart';
import 'package:counter/views/pages/widget/payment_method.dart';
import 'package:counter/views/pages/widget/payment_method_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hash_cached_image/hash_cached_image.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({super.key});

  Widget _buildPaymentMethod(
    PaymentCardModel? chosenPaymentCard,
    BuildContext context,
  ) {
    final size = MediaQuery.of(context).size;
    if (chosenPaymentCard != null) {
      return PaymentMethod(
        paymentCard: chosenPaymentCard,
        ontapped: () {
          showModalBottomSheet(
            context: context,
            builder: (_) {
              return SizedBox(
                width: double.infinity,
                height: size.height * .6,
                child: BlocProvider(
                  create: (context) {
                    final cubit = AddNewCardCubit();
                    cubit.fetchPaymentMethod();
                    return cubit;
                  },
                  child: PaymentMethodBottomSheet(),
                ),
              );
            },
          ).then(
            (onValue) =>
                BlocProvider.of<CheckoutCubit>(context).getCheckOutData(),
          );
        },
      );
    } else {
      return AddressAndPayment(title: "Add  Address", isPayment: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = CheckoutCubit();
        cubit.getCheckOutData();
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Checkout")),
        body: Builder(
          builder: (context) {
            return BlocBuilder<CheckoutCubit, CheckoutState>(
              bloc: BlocProvider.of<CheckoutCubit>(context),
              buildWhen:
                  (current, previous) =>
                      current is CheckoutError ||
                      current is CheckoutLoaded ||
                      current is CheckoutLoading,
              builder: (context, state) {
                if (state is CheckoutLoading) {
                  return Center(child: CircularProgressIndicator.adaptive());
                } else if (state is CheckoutError) {
                  return Center(child: Text(state.error));
                } else if (state is CheckoutLoaded) {
                  final chosenPaymentCard = state.chosenPaymentCards;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 4,
                    ),
                    child: SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CheckoutHeadlineItem(
                              title: "Address",
                              ontap: () {},
                            ),
                            AddressAndPayment(
                              title: 'Add shipping Address',
                              isPayment: false,
                            ),
                            CheckoutHeadlineItem(
                              title: "Products",
                              numOfProduct: state.numberOfProduct,
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              separatorBuilder:
                                  (context, index) =>
                                      Divider(color: AppColors.grey),
                              itemCount: state.cartItems.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: AppColors.greyShade,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: HashCachedImage(
                                        imageUrl:
                                            state
                                                .cartItems[index]
                                                .product
                                                .imgUrl,
                                        height: 100,
                                        width: 100,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.cartItems[index].product.name,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text.rich(
                                                TextSpan(
                                                  text: "Size :",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                        color: AppColors.grey,
                                                      ),
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          (state
                                                                  .cartItems[index]
                                                                  .sizeProduct
                                                                  .name)
                                                              .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                            color:
                                                                AppColors.black,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                "\$${(state.cartItems[index].totalPrice).toString()}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            SizedBox(height: 30),
                            CheckoutHeadlineItem(title: "Payment"),
                            //SizedBox(height: 30),
                            _buildPaymentMethod(chosenPaymentCard, context),
                            SizedBox(height: 30),

                            Divider(color: AppColors.grey),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Amount",
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .copyWith(color: AppColors.grey),
                                ),
                                Text("\$ ${state.subTotal + 10}"),
                              ],
                            ),
                            SizedBox(height: 40),
                            SizedBox(
                              height: 60,
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: AppColors.white,
                                ),
                                onPressed: () {},
                                child: Text("Process to Buy"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(child: Text("Something went wrong"));
                }
              },
            );
          },
        ),
      ),
    );
  }
}
