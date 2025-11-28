import 'package:counter/utlis/app_color.dart';
import 'package:flutter/material.dart';

class CounterWidget extends StatelessWidget {
  final int value;
  final int? initialValue;
  final String productId;
  final dynamic cubit;
  const CounterWidget({
    super.key,
    required this.value,
    required this.productId,
    required this.cubit,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.greyShade,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                 cubit.decrement(productId);
                    
              },
              icon: Icon(
                Icons.remove,
                color: value > 1 ? AppColors.black : AppColors.grey,
              ),
            ),
            Text(value.toString()),
            IconButton(
              onPressed:
                  () =>
                       cubit.increment(productId),
                 
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
