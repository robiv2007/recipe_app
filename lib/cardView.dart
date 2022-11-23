import 'package:flutter/material.dart';
import 'package:recipe_app/pages/recipe_overview_screen.dart';
import 'package:recipe_app/pages/detailed_recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeCard extends StatelessWidget {
  final String title;
  final String description;
  final String cookTime;
  final String thumbnailUrl;

  RecipeCard({
    required this.title,
    required this.description,
    required this.cookTime,
    required this.thumbnailUrl,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 180,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 237, 232, 232),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            offset: const Offset(
              0.0,
              10.0,
            ),
            blurRadius: 10.0,
            spreadRadius: -6.0,
          ),
        ],
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.35),
            BlendMode.multiply,
          ),
          image: NetworkImage(thumbnailUrl),
          fit: BoxFit.cover,
        ),
      ),
      
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                title,
                style: const TextStyle(fontSize: 19, color: Colors.white),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const SizedBox(width: 7),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.schedule,
                        color: Colors.yellow,
                        size: 18,
                      ),
                      const SizedBox(width: 7),
                      Text(cookTime, style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
// Paste
              ],
            ),
          ),
        ],
      ),
    ),
                      onTap: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => SecondRoute(title: title, description: description, thumbnailUrl: thumbnailUrl, cookTime: cookTime),
                  ));
                  },);
  }
}