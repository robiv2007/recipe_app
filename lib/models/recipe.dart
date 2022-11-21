import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe {
  final String title;
  final String thumbnailUrl;
  final String ingredients;
  final String steps;
  final String cookTime;
  final String rating;
  final Bool isVegetarianChecked;
  final Bool isLactoseFreeChecked;
  final Bool isGlutenFreeChecked;

  const Recipe(
      {required this.title,
      required this.thumbnailUrl,
      required this.ingredients,
      required this.steps,
      required this.cookTime,
      required this.rating,
      required this.isGlutenFreeChecked,
      required this.isLactoseFreeChecked,
      required this.isVegetarianChecked});
}
