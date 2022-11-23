import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/cardView.dart';
import 'package:recipe_app/main.dart';
import '../auth.dart';
import 'addRecipe.dart';
import 'recipe_overview_screen.dart';


class FavRoute extends StatelessWidget {
    final Auth _auth = Auth();

  final User? user = Auth().currentUser;

  final CollectionReference _recipes =
      FirebaseFirestore.instance.collection('Favorite');

  final String title;
  final String description;
  final String cookTime;
  final String thumbnailUrl;

    FavRoute(
      {Key? key,
      required this.title,
      required this.description,
      required this.cookTime,
      required this.thumbnailUrl, bool? isGlutenfreeChecked, bool? isLactoseFreeChecked, bool? isVegetarianChecked})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favorite'),
        ),
        body: StreamBuilder(
          stream: _recipes.snapshots(),
         builder:(context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length,
                        padding: EdgeInsets.all(16),
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];

                          return RecipeCard(
                            title: documentSnapshot['name'],
                            description: documentSnapshot['description'],
                            cookTime: documentSnapshot['CookTime'],
                            thumbnailUrl: documentSnapshot['thumbnailUrl'],
                          );
                        },
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
    );
  }

}