import 'package:counter/utlis/app_color.dart';
import 'package:counter/view_models/add_new_card_cubit/add_new_card_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hash_cached_image/hash_cached_image.dart';

class PaymentMethodBottomSheet extends StatelessWidget {
  const PaymentMethodBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Payment Method",
              style: Theme.of(
                context,
              ).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 36),
            BlocBuilder<AddNewCardCubit, AddNewCardState>(
              bloc: BlocProvider.of<AddNewCardCubit>(context),
              buildWhen:
                  (previous, current) =>
                      current is FetchPaymentMethodsError ||
                      current is FetchedPaymentMethods ||
                      current is FetchingPaymentMethods,
              builder: (context, state) {
                if (state is FetchingPaymentMethods) {
                  return Center(child: CircularProgressIndicator.adaptive());
                } else if (state is FetchPaymentMethodsError) {
                  return Center(child: Text(state.massage));
                } else if (state is FetchedPaymentMethods) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.paymentCards.length,
                    itemBuilder: (context, index) {
                      final paymentCardIndex = state.paymentCards[index];
                      return Card(
                        child: ListTile(
                          onTap:
                              () => BlocProvider.of<AddNewCardCubit>(
                                context,
                              ).changeChosenRadio(paymentCardIndex.id),

                          leading: DecoratedBox(
                            decoration: BoxDecoration(
                              color: AppColors.grey,

                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4.0,
                                horizontal: 6,
                              ),
                              child: HashCachedImage(
                                width: 50,
                                height: 50,
                                imageUrl:
                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/MasterCard_Logo.svg/1200px-MasterCard_Logo.svg.png",
                              ),
                            ),
                          ),
                          title: Text(state.paymentCards[index].cardNumber),
                          subtitle: Text(
                            state.paymentCards[index].cardHolderName,
                          ),
                          trailing: BlocBuilder<
                            AddNewCardCubit,
                            AddNewCardState
                          >(
                            bloc: BlocProvider.of<AddNewCardCubit>(context),
                            buildWhen:
                                (previous, current) =>
                                    current is ChangeChosenRadio ||
                                    current is FetchedPaymentMethods,
                            builder: (context, innerState) {
                              String? groupValueId;
                              if (innerState is ChangeChosenRadio) {
                                groupValueId = innerState.paymentCards.id;
                              } else if (innerState is FetchedPaymentMethods) {
                                // pick chosen card if exists, otherwise first
                                final chosen = innerState.paymentCards
                                    .firstWhere(
                                      (c) => c.isChosen == true,
                                      orElse:
                                          () => innerState.paymentCards.first,
                                    );
                                groupValueId = chosen.id;
                              }

                              return Radio<String>(
                                value: paymentCardIndex.id,
                                groupValue: groupValueId,
                                onChanged: (id) {
                                  BlocProvider.of<AddNewCardCubit>(
                                    context,
                                  ).changeChosenRadio(id!);
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
            SizedBox(height: 20),
            InkWell(
              onDoubleTap: () {},
              child: Card(
                child: ListTile(
                  leading: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(Icons.add),
                    ),
                  ),
                  title: Text("Add new card"),
                ),
              ),
            ),
            SizedBox(height: 16),
            BlocConsumer<AddNewCardCubit, AddNewCardState>(
              listenWhen: (previous, current) => current is ConfirmPaymentSuccess,
              listener: (context, state) {
                if (state is ConfirmPaymentSuccess) {
                  Navigator.of(context).pop();
                }
              },
              bloc: BlocProvider.of<AddNewCardCubit>(context),
              buildWhen: (previous, current) =>
                  current is ConfirmPaymentFailure ||
                  current is ConfirmPaymentLoading ||
                  current is ConfirmPaymentSuccess ||
                  current is FetchedPaymentMethods ||
                  current is ChangeChosenRadio,
              builder: (context, state) {
                // Show loading when confirming
                if (state is ConfirmPaymentLoading) {
                  return SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: null,
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  );
                }

                // Default: show Confirm button (enabled). If failure, show message above the button.
                return Column(
                  children: [
                    if (state is ConfirmPaymentFailure)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          state.massage,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                        ),
                        onPressed: () {
                          BlocProvider.of<AddNewCardCubit>(context).confirmPayment();
                        },
                        child: Text("Confirm Payment"),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
