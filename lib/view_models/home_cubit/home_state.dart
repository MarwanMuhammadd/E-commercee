part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeCubitInitial extends HomeState {}

// final class HomeLoading extends HomeState {}

// final class HomeLoaded extends HomeState {
//   final List<CarouselItemModel> carouselItem;
//   final List<ProductItemModel> productItems;

//   HomeLoaded({required this.carouselItem, required this.productItems});
// }

// final class HomeError extends HomeState {
//   final String massage;
//   HomeError({required this.massage});
// }
final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<CarouselItemModel> carouselItem;
  final List<ProductItemModel> productlItems;
  final List<CategoryModel>categoryItems;
  HomeLoaded({required this.carouselItem, required this.productlItems,required this.categoryItems});
}

final class HomeError extends HomeState {
  final String massage;

  HomeError({required this.massage});
}
