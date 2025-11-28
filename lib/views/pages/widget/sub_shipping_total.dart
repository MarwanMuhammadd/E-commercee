import 'package:counter/utlis/app_color.dart';
import 'package:flutter/material.dart';

class SubShippingTotal extends StatelessWidget {
  final String title;
  final double amount;
  const SubShippingTotal({
    super.key,
    required this.title,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColors.grey),
          ),
          //Spacer(),
          Text(
            "\$${amount.toStringAsFixed(2)}",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      
      ),
    );
  }
}
