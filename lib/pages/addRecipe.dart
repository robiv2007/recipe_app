import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'addRecipe.dart';

class addRecipes extends StatelessWidget {
  final String title;
  final String description;
  final String cookTime;
  final String thumbnailUrl;
  String id;

  addRecipes({
    this.id = "",
    required this.title,
    required this.description,
    required this.cookTime,
    required this.thumbnailUrl,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": title,
        "CookTime": cookTime,
        "description": description,
        "thumbnailUrl": thumbnailUrl,
      };

      static addRecipes fromJson(Map<String, dynamic> json) =>addRecipes(
        id: json["id"],
        title: json["name"],
        cookTime: json["cookTime"],
        description: json["description"],
        thumbnailUrl: json["thumbnail"],

      );

  final titleName = TextEditingController();
  final titleDescription = TextEditingController();
  final titleRating = TextEditingController();
  final titleCookTime = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe App"),
      ),
      body: buildTextFields(),
    );
  }

  Widget buildTextFields() => Padding(
        padding: const EdgeInsets.all(35),
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTextFormFieldName(),
              heightSpacer(15),
              buildTextFormFieldCookTime(),
              heightSpacer(15),
              buildTextFormFieldDescription(),
              heightSpacer(15),
              SizedBox(
                width: 100,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    final name = titleName.text;
                    final description = titleDescription.text;
                    final cookTime = titleCookTime.text;
                    createRecepe(
                        name: name, descriptions: description, time: cookTime);
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildTextFormFieldName() => TextFormField(
        controller: titleName,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(5.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
            ),
          ),
          prefixIcon: Icon(
            Icons.food_bank,
            color: Colors.orange,
          ),
          filled: true,
          fillColor: Colors.orange[50],
          labelText: "Recipe Name",
          labelStyle: TextStyle(color: Colors.orange),
        ),
      );

  Widget heightSpacer(double myHeight) => SizedBox(
        height: myHeight,
      );

  Widget buildTextFormFieldCookTime() => TextFormField(
        controller: titleCookTime,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(5.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
            ),
          ),
          prefixIcon: Icon(
            Icons.timer,
            color: Colors.orange,
          ),
          filled: true,
          fillColor: Colors.orange[50],
          labelText: "Timer",
          labelStyle: TextStyle(color: Colors.orange),
        ),
      );

  Widget buildTextFormFieldDescription() => TextField(
        controller: titleDescription,
        minLines: 2,
        maxLines: 5,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(5.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
            ),
          ),
          prefixIcon: Icon(
            Icons.description,
            color: Colors.orange,
          ),
          filled: true,
          fillColor: Colors.orange[50],
          labelText: "description",
          labelStyle: TextStyle(color: Colors.orange),
        ),
      );

  Stream<List<addRecipes>> readUsers() => FirebaseFirestore.instance
      .collection("Recipe")
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => addRecipes.fromJson(doc.data())).toList());

  Future<dynamic> createRecepe(
      {required String name,
      required String descriptions,
      required String time}) async {
    final docUser = FirebaseFirestore.instance.collection("Recipes").doc();
    FirebaseAuth auth = FirebaseAuth.instance;
    String userUid = auth.currentUser!.uid.toString();

    final recipe = addRecipes(
      id: docUser.id,
      title: name,
      description: descriptions,
      cookTime: time,
      thumbnailUrl: "test.jpg",
    );
    final recipesData = recipe.toJson();

    await docUser.set(recipesData);
  }
}
