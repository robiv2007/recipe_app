import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'addRecipe.dart';

class addRecipes extends StatefulWidget {
  const addRecipes({
    super.key,
    required id,
    required thumbnailUrl,
    required title,
    required cookTime,
    required description,
  });

  @override
  State<addRecipes> createState() => _addRecipesState(
        title: "",
        cookTime: "time",
        description: "description",
        thumbnailUrl: "",
      );

  static fromJson(Map<String, dynamic> data) {}
}

class _addRecipesState extends State<addRecipes> {
  final String title;
  final String description;
  final String cookTime;
  final String thumbnailUrl;
  String id;

  _addRecipesState({
    this.id = "",
    required this.title,
    required this.description,
    required this.cookTime,
    required this.thumbnailUrl,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "thumbnailUrl": thumbnailUrl,
        "name": title,
        "CookTime": cookTime,
        "description": description,
      };

  static _addRecipesState fromJson(Map<String, dynamic> json) =>
      _addRecipesState(
        id: json["id"],
        thumbnailUrl: json["thumbnail"],
        title: json["name"],
        cookTime: json["cookTime"],
        description: json["description"],
      );

  final titleName = TextEditingController();
  final titleDescription = TextEditingController();
  final titleCookTime = TextEditingController();

  Widget buildTextFields() => Padding(
        padding: const EdgeInsets.all(35),
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              child:  Center(
                selectImage != null
                    child: _image == null ? const Text("No image selected",style: TextStyle(fontSize: 20),
                      )
                    :selectImage(),
              buildImagePicker(
                title: "Pick Galerry",
                icon: Icons.image_outlined,
                onClicked: (thumbnailUrl) => selectImage(),
              ), 
              ),
              const SizedBox(height: 40),
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
  Widget buildImagePicker({
    required String title,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(40),
          primary: Colors.amber,
          onPrimary: Colors.black,
          textStyle: const TextStyle(fontSize: 15),
        ),
        child: Row(children: [
          Icon(icon, size: 28),
          const SizedBox(
            width: 16,
          ),
          Text(title),
        ]),
        onPressed: () {}
          
      );

  Widget buildTextFormFieldName() => TextFormField(
        controller: titleName,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(5.5),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
            ),
          ),
          prefixIcon: const Icon(
            Icons.food_bank,
            color: Colors.orange,
          ),
          filled: true,
          fillColor: Colors.orange[50],
          labelText: "Recipe Name",
          labelStyle: const TextStyle(color: Colors.orange),
        ),
      );

  Widget heightSpacer(double myHeight) => SizedBox(
        height: myHeight,
      );

  Widget buildTextFormFieldCookTime() => TextFormField(
        controller: titleCookTime,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(5.5),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
            ),
          ),
          prefixIcon: const Icon(
            Icons.timer,
            color: Colors.orange,
          ),
          filled: true,
          fillColor: Colors.orange[50],
          labelText: "Timer",
          labelStyle: const TextStyle(color: Colors.orange),
        ),
      );

  Widget buildTextFormFieldDescription() => TextField(
        controller: titleDescription,
        minLines: 2,
        maxLines: 5,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(5.5),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
            ),
          ),
          prefixIcon: const Icon(
            Icons.description,
            color: Colors.orange,
          ),
          filled: true,
          fillColor: Colors.orange[50],
          labelText: "description",
          labelStyle: const TextStyle(color: Colors.orange),
        ),
      );

  File? _image;

  Future selectImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      setState(() {
        _image = img;
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  //  Future<dynamic> uploadImage() async {
  //  final file = File(selectImage);
  //    final path = "Images/${selectImage.toString()}";
  // }

  Stream<List<_addRecipesState>> readUsers() => FirebaseFirestore.instance
      .collection("Recipe")
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => _addRecipesState.fromJson(doc.data()))
          .toList());

  Future<dynamic> createRecepe(
      {required String name,
      required String descriptions,
      required String time}) async {
    final docUser = FirebaseFirestore.instance.collection("Recipes").doc();
    FirebaseAuth auth = FirebaseAuth.instance;
    String userUid = auth.currentUser!.uid.toString();

    final recipe = _addRecipesState(
      id: docUser.id,
      thumbnailUrl: "test.jpg",
      title: name,
      cookTime: time,
      description: descriptions,
    );
    final recipesData = recipe.toJson();

    await docUser.set(recipesData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipe App"),
      ),
      body: buildTextFields(),
    );
  }
}
