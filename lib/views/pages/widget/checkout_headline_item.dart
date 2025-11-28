import 'package:flutter/material.dart';

class CheckoutHeadlineItem extends StatelessWidget {
  final String title;
  final int? numOfProduct;
  final VoidCallback? ontap;
  const CheckoutHeadlineItem({
    super.key,
    required this.title,
    this.numOfProduct,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all( 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(title, style: Theme.of(context).textTheme.bodyLarge),
              if (numOfProduct != null)
                Text(
                  "($numOfProduct)",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
            ],
          ),
          if (ontap != null) TextButton(onPressed: ontap, child: Text("Edit")),
        ],
      ),
    );
  }
}
