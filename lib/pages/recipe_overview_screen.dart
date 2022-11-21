import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/cardView.dart';
import 'package:recipe_app/main.dart';
import '../auth.dart';
import 'addRecipe.dart';

class RecipeOverviewScreen extends StatefulWidget {
  const RecipeOverviewScreen({super.key});

  @override
  State<RecipeOverviewScreen> createState() => _RecipeOverviewScreenState();
}

class _RecipeOverviewScreenState extends State<RecipeOverviewScreen> {
  final Auth _auth = Auth();

  final User? user = Auth().currentUser;

  final CollectionReference _recipes =
      FirebaseFirestore.instance.collection('Recipes');

  bool lactose = false;
  bool vegetarian = false;
  bool glutenFree = false;
  String searchText = "";

  firebaseSorting() {
    if (vegetarian == true) {
      return FirebaseFirestore.instance
          .collection('Recipes')
          .where('isVegetarianChecked', isEqualTo: vegetarian)
          .snapshots();
    } else if (lactose == true) {
      return FirebaseFirestore.instance
          .collection('Recipes')
          .where('isLactoseFreeChecked', isEqualTo: lactose)
          .snapshots();
    } else if (glutenFree == true) {
      return FirebaseFirestore.instance
          .collection('Recipes')
          .where('isGlutenFreeChecked', isEqualTo: glutenFree)
          .snapshots();
    } else {
      return FirebaseFirestore.instance.collection('Recipes').snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.orange),
                child: Text(
                  "MENU",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ListTile(
                /*Add Recipe button*/
                leading: Icon(Icons.add_circle_outline),
                title: const Text("Add Recipe"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const addRecipes(
                              id: "",
                              title: "name",
                              description: "description",
                              cookTime: "cookTime",
                              thumbnailUrl: "thumbnailUrl",
                              isGlutenfreeChecked: false,
                              isLactoseFreeChecked: false,
                              isVegetarianChecked: false)));
                },
              ),
              ListTile(
                leading: Icon(Icons.favorite_border),
                title: Text("Favorite"),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(title: "recipe"),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('LOG OUT'),
                onTap: () async {
                  await _auth.signOut();
                },
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("Recipe"),
        ),
        body: Column(
          children: <Widget>[
            // TextField(
            //   decoration: InputDecoration(
            //     filled: true,
            //     fillColor: Colors.grey[300],
            //     border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(8.0),
            //         borderSide: BorderSide.none),
            //     hintText: "Search for recipes...",
            //     suffixIcon: const Icon(Icons.search),
            //   ),
            //   onChanged: (value) {
            //     setState(() {
            //       searchText = value;
            //     });
            //   },
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.amber,
                  ),
                  onPressed: () => {
                    if (vegetarian || glutenFree == true)
                      {null}
                    else
                      {setState(() => lactose = !lactose)}
                  },
                  child: Text(lactose ? 'Selected' : 'Lactose Free'),
                ),
                SizedBox(
                  width: 15,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.amber,
                  ),
                  onPressed: () => {
                    if (lactose || vegetarian == true)
                      {null}
                    else
                      {setState(() => glutenFree = !glutenFree)}
                  },
                  child: Text(glutenFree ? 'Selected' : 'Gluten Free'),
                ),
                SizedBox(
                  width: 15,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.amber,
                  ),
                  onPressed: () => {
                    if (lactose || glutenFree == true)
                      {null}
                    else
                      {setState(() => vegetarian = !vegetarian)}
                  },
                  child: Text(vegetarian ? 'Selected' : 'Vegetarian'),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder(
                  stream: firebaseSorting(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length,
                        padding: EdgeInsets.all(16),
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];

                          return RecipeCard(
                            title: documentSnapshot['name'],
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
            )
          ],
        ));
  }
}
