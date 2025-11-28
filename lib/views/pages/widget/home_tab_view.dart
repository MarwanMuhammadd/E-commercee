
import 'package:counter/utlis/app_routes.dart';
import 'package:counter/view_models/home_cubit/home_cubit.dart';
import 'package:counter/views/pages/widget/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:hash_cached_image/hash_cached_image.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: BlocProvider.of<HomeCubit>(context),
      builder: (context, state) {
        if (state is HomeLoading) {
          return Center(child: CircularProgressIndicator.adaptive());
        } else if (state is HomeLoaded) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                FlutterCarousel.builder(
                  itemCount: state.carouselItem.length,
                  itemBuilder:
                      (context, index, indexItem) => Padding(
                        padding: const EdgeInsetsDirectional.only(end: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: HashCachedImage(
                            imageUrl: state.carouselItem[index].imgUrl,
                            fit: BoxFit.cover,
                            placeholder:
                                (context) =>
                                    CircularProgressIndicator.adaptive(),
                            errorWidget:
                                (context, error, stackTrace) =>
                                    Icon(Icons.error),
                          ),
                        ),
                      ),
                  options: FlutterCarouselOptions(
                    height: 200,
                    autoPlay: true,
                    showIndicator: true,
                    slideIndicator: CircularWaveSlideIndicator(),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'New Arrival',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'see all',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                GridView.builder(
                  itemCount: state.productlItems.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 230,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap:
                          () => Navigator.of(
                            context,
                            rootNavigator: true,
                          ).pushNamed(AppRoutes.foodDetailsRoute,arguments:state.productlItems[index].id ),
                      child: ProductItem(
                        //productItem: state.productlItems[index],
                        productItem: state.productlItems[index],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        } else if (state is HomeError) {
          return Center(child: Text(state.massage));
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
