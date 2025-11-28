import 'package:counter/models/payment_card_model.dart';
import 'package:counter/utlis/app_color.dart';
import 'package:flutter/material.dart';
import 'package:hash_cached_image/hash_cached_image.dart';

class PaymentMethod extends StatelessWidget {
  final PaymentCardModel paymentCard;
  final VoidCallback ontapped;
  const PaymentMethod({super.key, required this.paymentCard,required this.ontapped});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontapped,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.grey),
        ),
        child: ListTile(
          leading: HashCachedImage(
            imageUrl:
                "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/MasterCard_Logo.svg/1200px-MasterCard_Logo.svg.png",
                width: 50,
                height: 50,
                fit:BoxFit.contain
          ),
          title: Text("Master Card"),
          subtitle: Text(paymentCard.cardNumber),
          trailing: Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
