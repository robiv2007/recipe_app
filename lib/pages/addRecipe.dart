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

  addRecipes({
    required this.title,
    required this.description,
    required this.cookTime,
    required this.thumbnailUrl,
  });

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
                child: ElevatedButton(onPressed: (){
                  final name = titleName.text;
                 final description = titleDescription.text;
                 final cookTime = titleCookTime.text;
                 createRecepe(name: name, descriptions: description, time:cookTime);
                 },
                 child: const Text("Save", style: TextStyle(color: Colors.white),
                  ),
                 ),
              ),
              // IconButton(
              // onPressed: () {
              //   final name = titleName.text;
              //   final description = titleDescription.text;
              //   final cookTime = titleCookTime.text;
              //   createRecepe(name: name, descriptions: description, time:cookTime);
              // },
              // icon: Icon(Icons.add)),
            ],
          ),
        ),
      );

  Widget buildTextFormFieldName() => TextFormField(controller: titleName,
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

  Widget buildTextFormFieldCookTime() => TextFormField(controller: titleCookTime,
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
  

  Widget buildTextFormFieldDescription() => TextField(controller: titleDescription, 
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

  Future<dynamic> createRecepe({required String name,required String descriptions, required String time }) async {
    final docUser =
        FirebaseFirestore.instance.collection("Recipes").doc("my-id");
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    
    final recipe = {
      uid: uid,
      title: name,
      description: descriptions,
      cookTime: time,
      thumbnailUrl: "test.jpg",
    };

    await docUser.set(recipe);
  }
}
