
import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe {
  final String title;
  final String thumbnailUrl;
  final String ingredients;
  final String steps;
  final String cookTime;
  final String rating;
 
  

  const Recipe({
     required this.title,
     required this.thumbnailUrl,
     required this.ingredients,
     required this.steps,
     required this.cookTime,
     required this.rating,
  });
}