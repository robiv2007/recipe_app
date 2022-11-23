import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import "favorites.dart";

class SecondRoute extends StatelessWidget {
  final String title;
  final String description;
  final String cookTime;
  final String thumbnailUrl;

  const SecondRoute(
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
                      child: Text(title, style: const TextStyle(fontSize: 20))),
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
                    child: Text(description, style: const TextStyle(fontSize: 20))),
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
                        style: const TextStyle(fontSize: 20))),
              ),
              _MyStatelessWidget(
                  title: title,
                  description: description,
                  thumbnailUrl: thumbnailUrl,
                  cookTime: cookTime,
                  isGlutenfreeChecked: false,
                  isLactoseFreeChecked: false,
                  isVegetarianChecked: false,),
            ],
          ),
        ),
      ),
    );
  }
}

class _MyStatelessWidget extends StatelessWidget {
  
  String? title;
  String? description;
  String? cookTime;
  String? thumbnailUrl;
  String? id;
  bool? isVegetarianChecked = false;
  bool? isGlutenfreeChecked = false;
  bool? isLactoseFreeChecked = false;
  


    Map<String, dynamic> toJson() => {
       "thumbnailUrl": thumbnailUrl,
        "name": title,
        "CookTime": cookTime,
        "description": description,
        "isVegetarianChecked": isVegetarianChecked,
        "isLactoseFreeChecked": isLactoseFreeChecked,
        "isGlutenFreeChecked": isGlutenfreeChecked
      };

      _MyStatelessWidget(
      {this.id = "",
      required this.title,
      required this.description,
      required this.cookTime,
      required this.thumbnailUrl,
      required this.isGlutenfreeChecked,
      required this.isLactoseFreeChecked,
      required this.isVegetarianChecked});

      
  static _MyStatelessWidget fromJson(Map<String, dynamic> json) =>
      _MyStatelessWidget(
          id: json["id"],
          thumbnailUrl: json["thumbnail"],
          title: json["name"],
          cookTime: json["cookTime"],
          description: json["description"],
          isGlutenfreeChecked: json["isGlutenFreeChecked"],
          isLactoseFreeChecked: json["isLactoseFreeChecked"],
          isVegetarianChecked: json["isVegetarianChecked"],
          );
     Stream<List<_MyStatelessWidget>> readUsers() => FirebaseFirestore.instance
      .collection("Favourite")
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) =>_MyStatelessWidget.fromJson(doc.data()))
          .toList());

  Future<dynamic> createFavorite({String? title, String? description, String? cookTime, String? thumbnailUrl}
       
      ) async {
    final docUser = FirebaseFirestore.instance.collection("Favorite").doc();
    FirebaseAuth auth = FirebaseAuth.instance;

    final recipe = _MyStatelessWidget(
        thumbnailUrl: thumbnailUrl,
        title: title,
        cookTime: cookTime,
        description: description,
        isGlutenfreeChecked: isGlutenfreeChecked,
        isLactoseFreeChecked: isLactoseFreeChecked,
        isVegetarianChecked: isVegetarianChecked,
    );
    final recipesData = recipe.toJson();

    await docUser.set(recipesData);
  }
////////////
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
                              title: "name",
                              description: "description",
                              cookTime: "cookTime",
                              thumbnailUrl: "thumbnailUrl",
                              isGlutenfreeChecked: false,
                              isLactoseFreeChecked: false,
                              isVegetarianChecked: false)));
                                    createFavorite(
                                        title: title,
                                        description: description,
                                        thumbnailUrl: thumbnailUrl,
                                        cookTime: cookTime,
                                        );
                                        
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
