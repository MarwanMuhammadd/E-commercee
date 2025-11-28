import 'package:counter/models/carousel_item_model.dart';
import 'package:counter/models/category_item_model.dart';
import 'package:counter/models/product_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeCubitInitial());
  // void getData() {
  //   emit(HomeLoading());
  //   Future.delayed(Duration(seconds: 2), () {
  //     emit(
  //       HomeLoaded(
  //         carouselItem: carouselItemModel,
  //         productItems: dummyProductItem,
  //       ),
  //     );
  //   });

  // }
  void getData() {
    emit(HomeLoading());
    Future.delayed(Duration(seconds: 2), () {
      emit(
        HomeLoaded(
          carouselItem: carouselItemModel,
          productlItems: dummyProductItem,
          categoryItems: dummyCategories,
        ),
      );
    });
  }
}
