import 'package:counter/utlis/app_color.dart';
import 'package:counter/utlis/app_routes.dart';
import 'package:counter/view_models/checkout_cubit/checkout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressAndPayment extends StatelessWidget {
  final String title;
  final bool isPayment;
  const AddressAndPayment({
    super.key,
    required this.title,
    required this.isPayment,
  });

  @override
  Widget build(BuildContext context) {
    final checkoutCubit = BlocProvider.of<CheckoutCubit>(context);
    return InkWell(
      onTap: () {
        if (isPayment == true) {
          Navigator.of(context)
              .pushNamed(AppRoutes.addNewCard)
              .then((onValue) => checkoutCubit.getCheckOutData());
        } else {
          Navigator.of(context).pushNamed(AppRoutes.choseLocation);
        }
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.grey,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Icon(Icons.add), Text(title)],
          ),
        ),
      ),
    );
  }
}
