import 'package:counter/models/product_item_model.dart';
import 'package:counter/utlis/app_color.dart';
import 'package:counter/view_models/product_details_cubit/porduct_details_cubit.dart';
import 'package:counter/views/pages/widget/counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hash_cached_image/hash_cached_image.dart';

class ProductDetailsPage extends StatelessWidget {
  final String productId;
  const ProductDetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<PorductDetailsCubit, PorductDetailsState>(
      bloc: BlocProvider.of<PorductDetailsCubit>(context),
      buildWhen:
          (previous, current) =>
              current is ProductDetailsLoaded ||
              current is ProductDetailsLoading ||
              current is ProductDetailsError,
      builder: (context, state) {
        if (state is ProductDetailsLoading) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()),
          );
        }
        if (state is ProductDetailsLoaded) {
          final product = state.product;
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Center(child: Text("Product Details")),
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
              ],
            ),
            body: Stack(
              children: [
                Container(
                  height: size.height * .45,
                  color: AppColors.greyShade,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: size.height * .07,
                      left: 8,
                      right: 8,
                    ),
                    child: HashCachedImage(
                      imageUrl: state.product.imgUrl,
                      height: size.height * .30,
                      width: size.width * 1,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * .44),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        topLeft: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 18.0,
                                horizontal: 16,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.product.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.star, color: AppColors.yellow),
                                      Text(
                                        state.product.avgRate.toString(),
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: BlocBuilder<
                                PorductDetailsCubit,
                                PorductDetailsState
                              >(
                                bloc: BlocProvider.of<PorductDetailsCubit>(
                                  context,
                                ),
                                buildWhen:
                                    (previous, current) =>
                                        current is ProductDetailsLoaded ||
                                        current is QuantityCounterLoaded,
                                builder: (context, state) {
                                  if (state is QuantityCounterLoaded) {
                                    return CounterWidget(
                                      value: state.value,
                                      productId: product.id,
                                      cubit:
                                          BlocProvider.of<PorductDetailsCubit>(
                                            context,
                                          ),
                                    );
                                  } else if (state is ProductDetailsLoaded) {
                                    return CounterWidget(
                                      value: 1,
                                      productId: state.product.id,
                                      cubit:
                                          BlocProvider.of<PorductDetailsCubit>(
                                            context,
                                          ),
                                    );
                                  } else {
                                    return SizedBox.shrink();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 28.0),
                          child: Text(
                            "Size",
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        BlocBuilder<PorductDetailsCubit, PorductDetailsState>(
                          bloc: BlocProvider.of<PorductDetailsCubit>(context),
                          buildWhen:
                              (previous, current) =>
                                  current is SizeSelected ||
                                  current is ProductDetailsLoaded,
                          builder: (context, state) {
                            return Row(
                              children:
                                  ProductSize.values
                                      .map(
                                        (toElement) => Padding(
                                          padding: const EdgeInsets.only(
                                            left: 22.0,
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              BlocProvider.of<
                                                PorductDetailsCubit
                                              >(
                                                context,
                                              ).selectedSize(toElement);
                                            },
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                color:
                                                    state is SizeSelected &&
                                                            state.size ==
                                                                toElement
                                                        ? AppColors.primary
                                                        : AppColors.greyShade,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  8.0,
                                                ),
                                                child: Text(
                                                  toElement.name,
                                                  style: Theme.of(
                                                    context,
                                                  ).textTheme.bodyMedium!.copyWith(
                                                    color:
                                                        state is SizeSelected &&
                                                                state.size ==
                                                                    toElement
                                                            ? AppColors.white
                                                            : AppColors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                            );
                          },
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(left: 28.0),
                          child: Text(
                            "Description",
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Text(state.product.description),
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text.rich(
                                TextSpan(
                                  text: '\$',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyLarge!.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: state.product.price.toString(),
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge!.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            BlocBuilder<
                              PorductDetailsCubit,
                              PorductDetailsState
                            >(
                              bloc: BlocProvider.of<PorductDetailsCubit>(
                                context,
                              ),
                              buildWhen:
                                  (previous, current) =>
                                      current is ProductAddedToCart ||
                                      current is ProductAddingToCart ||
                                      current is ProductDetailsLoaded,
                              builder: (context, state) {
                                if (state is ProductAddingToCart) {
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      foregroundColor: AppColors.white,
                                    ),
                                    onPressed: null,
                                    child: CircularProgressIndicator.adaptive(),
                                  );
                                } else if (state is ProductAddedToCart) {
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      foregroundColor: AppColors.white,
                                    ),
                                    onPressed: null,
                                    child: Text("added"),
                                  );
                                } else if (state is ProductDetailsLoaded) {
                                  return ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      foregroundColor: AppColors.white,
                                    ),
                                    onPressed: () {
                                      if (BlocProvider.of<PorductDetailsCubit>(
                                            context,
                                          ).Size !=
                                          null) {
                                        BlocProvider.of<PorductDetailsCubit>(
                                          context,
                                        ).addToCard(state.product.id);
                                      } else {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text("Choose Size Please"),
                                          ),
                                        );
                                      }
                                    },
                                    label: Text("Add to card"),
                                    icon: Icon(Icons.shopping_basket_outlined),
                                  );
                                } else {
                                  return SizedBox.shrink();
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        if (state is ProductDetailsError) {
          return Scaffold(body: Text(state.massage));
        } else {
          return Scaffold(body: SizedBox.shrink());
        }
      },
    );
  }
}
