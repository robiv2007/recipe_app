import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/cardView.dart';
import 'package:recipe_app/main.dart';
import '../auth.dart';
import 'addRecipe.dart';
import "favorites.dart";

class SecondRoute extends StatelessWidget {
  final String title;
  final String description;
  final String cookTime;
  final String thumbnailUrl;

  SecondRoute(
      {Key? key,
      required this.title,
      required this.description,
      required this.cookTime,
      required this.thumbnailUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  height: 200.0,
                  image: NetworkImage(thumbnailUrl),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.grey,
                    ),
                  ],
                ),
                child: Center(
                  child: FittedBox(
                      child: Text(title, style: TextStyle(fontSize: 20))),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: 350,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.orange,
                    width: 5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.yellow,
                    ),
                  ],
                ),
                child: Center(
                    child: Text(description, style: TextStyle(fontSize: 20))),
              ),
              const SizedBox(height: 30),
              Container(
                width: 250,
                height: 70,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.yellow,
                    width: 5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.orange,
                    ),
                  ],
                ),
                child: Center(
                    child: Text("CookTime : $cookTime min",
                        style: TextStyle(fontSize: 20))),
              ),
              MyStatelessWidget(
                  title: title,
                  description: description,
                  thumbnailUrl: thumbnailUrl,
                  cookTime: cookTime),
            ],
          ),
        ),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget(
      {super.key,
      required this.title,
      required this.description,
      required this.cookTime,
      required this.thumbnailUrl});

  final String title;
  final String description;
  final String cookTime;
  final String thumbnailUrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 30),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF0D47A1),
                          Color(0xFF1976D2),
                          Color(0xFF42A5F5),
                        ],
                      ),
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16.0),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Save Recipe'),
                      content: const Text(
                          'Do you want to save this recipe to your favourites?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'Save');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FavRoute(
                                        title: title,
                                        description: description,
                                        thumbnailUrl: thumbnailUrl,
                                        cookTime: cookTime)));
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  ),
                  child: const Text('Save Recipe'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
