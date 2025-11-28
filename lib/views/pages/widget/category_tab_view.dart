import 'package:counter/models/category_item_model.dart';
import 'package:counter/view_models/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryTabView extends StatelessWidget {
  const CategoryTabView({super.key});
  Column columnText(BuildContext context, int index) {
    return Column(
      children: [
        Text(
          dummyCategories[index].name,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: dummyCategories[index].textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "${dummyCategories[index].productsCount} Products",
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: dummyCategories[index].textColor,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: BlocProvider.of<HomeCubit>(context),
      builder: (context, state) {
        if (state is HomeLoading) {
          return Center(child: CircularProgressIndicator.adaptive());
        } else if (state is HomeLoaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final category = state.categoryItems[index];
              final isEven = index % 2 == 0;
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 8,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: category.bgColor,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 20,
                    ),
                    child:
                        isEven
                            ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                columnText(context, index),
                                Image.network(
                                  category.imageUrl ??
                                      'assets/images/default.png',
                                  width: 120,
                                  height: 90,
                                ),
                              ],
                            )
                            : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.network(
                                  category.imageUrl ??
                                      'assets/images/default.png',
                                  width: 120,
                                  height: 90,
                                ),
                                columnText(context, index),
                              ],
                            ),
                  ),
                ),
              );
            },
            itemCount: dummyCategories.length,
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
