import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                        builder: (context) => addRecipes(
                            id: "",
                            title: "name",
                            description: "description",
                            cookTime: "cookTime",
                            thumbnailUrl: "thumbnailUrl")));
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
      body: StreamBuilder(
          stream: _recipes.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
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
    );
  }
}
