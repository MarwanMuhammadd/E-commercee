import 'dart:ui';
import 'package:counter/utlis/app_color.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String name;
  final int productsCount;
  final Color bgColor;
  final Color textColor;
    final String imageUrl;


  CategoryModel({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.productsCount,
     this.bgColor=Colors.deepPurple,
     this.textColor=Colors.deepPurple,
  });
}

List<CategoryModel> dummyCategories = [
  CategoryModel(
    id: '1',
    name: 'New Arrivals',
    productsCount: 208,
    bgColor: AppColors.grey,
    textColor: AppColors.black,
    imageUrl: 'https://pngimg.com/d/men_shoes_PNG7475.png',
  ),
  CategoryModel(
    id: '2',
    name: 'Clothes',
    productsCount: 358,
    bgColor: AppColors.green,
    textColor: AppColors.white,
    imageUrl: 'https://pngimg.com/d/men_shoes_PNG7475.png',
  ),
  CategoryModel(
    id: '3',
    name: 'Bags',
    productsCount: 160,
    bgColor: AppColors.black,
    textColor: AppColors.white,
    imageUrl: 'https://pngimg.com/d/men_shoes_PNG7475.png',
  ),
  CategoryModel(
    id: '4',
    name: 'Shoes',
    productsCount: 230,
    bgColor: AppColors.grey,
    textColor: AppColors.black,
    imageUrl: 'https://pngimg.com/d/men_shoes_PNG7475.png',
  ),
  CategoryModel(
    id: '5',
    name: 'Electronics',
    productsCount: 101,
    bgColor: AppColors.blue,
    textColor: AppColors.white,
    imageUrl: 'https://pngimg.com/d/men_shoes_PNG7475.png',
  ),
];
