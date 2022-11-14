import 'package:flutter/material.dart';
import 'package:recipe_app/cardView.dart';
import 'package:recipe_app/main.dart';
import '../auth.dart';

class RecipeOverviewScreen extends StatefulWidget {
  const RecipeOverviewScreen({super.key});

  @override
  State<RecipeOverviewScreen> createState() => _RecipeOverviewScreenState();
}

class _RecipeOverviewScreenState extends State<RecipeOverviewScreen> {
  final Auth _auth = Auth();
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
        body: ListView.builder(
          padding: EdgeInsets.all(16),
          itemBuilder: (context, index) {
            return RecipeCard(
              title: "pizza",
              cookTime: "40",
              rating: "8",
              thumbnailUrl:
                  "https://assets.biggreenegg.eu/app/uploads/2021/04/30120446/topimage-pizza-margherita-2021m05-800x533-1.jpg",
            );
          },
        ));
  }
}
