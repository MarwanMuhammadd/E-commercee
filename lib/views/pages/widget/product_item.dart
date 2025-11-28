import 'package:counter/models/product_item_model.dart';
import 'package:flutter/material.dart';
import 'package:hash_cached_image/hash_cached_image.dart';

class ProductItem extends StatelessWidget {
  final ProductItemModel productItem;
  const ProductItem({super.key, required this.productItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 130,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade400,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: HashCachedImage(
                  imageUrl: productItem.imgUrl,
                  placeholder:
                      (context) => CircularProgressIndicator.adaptive(),
                  errorWidget: (context, error, stackRace) => Icon(Icons.error),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white54,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_border),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          productItem.name,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
        ),
        Text(
          productItem.category,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
        ),
        Text(
          "\$ ${productItem.price}",
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
