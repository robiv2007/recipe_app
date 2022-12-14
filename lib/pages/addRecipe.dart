import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/pages/recipe_overview_screen.dart';
import 'addRecipe.dart';

class addRecipes extends StatefulWidget {
  const addRecipes(
      {super.key,
      required id,
      required thumbnailUrl,
      required title,
      required cookTime,
      required description,
      required isLactoseFreeChecked,
      required isVegetarianChecked,
      required isGlutenfreeChecked});

  @override
  State<addRecipes> createState() => _addRecipesState(
      title: "",
      cookTime: "time",
      description: "description",
      thumbnailUrl: "",
      isGlutenfreeChecked: false,
      isLactoseFreeChecked: false,
      isVegetarianChecked: false);

  static fromJson(Map<String, dynamic> data) {}
}

class _addRecipesState extends State<addRecipes> {
  final String title;
  final String description;
  final String cookTime;
  String thumbnailUrl;
  String id;
  bool? isVegetarianChecked = false;
  bool? isGlutenfreeChecked = false;
  bool? isLactoseFreeChecked = false;

  _addRecipesState(
      {this.id = "",
      required this.title,
      required this.description,
      required this.cookTime,
      required this.thumbnailUrl,
      required this.isGlutenfreeChecked,
      required this.isLactoseFreeChecked,
      required this.isVegetarianChecked});

  Map<String, dynamic> toJson() => {
        "id": id,
        "thumbnailUrl": thumbnailUrl,
        "name": title,
        "CookTime": cookTime,
        "description": description,
        "isVegetarianChecked": isVegetarianChecked,
        "isLactoseFreeChecked": isLactoseFreeChecked,
        "isGlutenFreeChecked": isGlutenfreeChecked
      };

  static _addRecipesState fromJson(Map<String, dynamic> json) =>
      _addRecipesState(
          id: json["id"],
          thumbnailUrl: json["thumbnail"],
          title: json["name"],
          cookTime: json["cookTime"],
          description: json["description"],
          isGlutenfreeChecked: json["isGlutenFreeChecked"],
          isLactoseFreeChecked: json["isLactoseFreeChecked"],
          isVegetarianChecked: json["isVegetarianChecked"]);

  final titleName = TextEditingController();
  final titleDescription = TextEditingController();
  final titleCookTime = TextEditingController();

  Widget buildTextFields() => Padding(
        padding: const EdgeInsets.all(35),
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              image != null
                  ? ClipOval(
                      child: thumbnailUrl == ""
                          ? Image.file(
                              image!,
                              width: 130,
                              height: 130,
                              fit: BoxFit.cover,
                            )
                          : Image.network(thumbnailUrl, width: 150, height: 150, fit: BoxFit.cover),
                    )
                  : const FlutterLogo(size: 150),
              buildImagePicker(
                icon: Icons.add_a_photo,
                onClicked: () {
                  pickImage();
                },
              ),
              const SizedBox(height: 40),
              buildTextFormFieldName(),
              heightSpacer(15),
              buildTextFormFieldCookTime(),
              heightSpacer(15),
              buildTextFormFieldDescription(),
              heightSpacer(15),
              Row(
                children: [
                  Checkbox(
                      value: isLactoseFreeChecked,
                      onChanged: (newBool) {
                        setState(() {
                          isLactoseFreeChecked = newBool;
                        });
                      }),
                  const Text("Lactose Free")
                ],
              ),
              Row(
                children: [
                  Checkbox(
                      value: isVegetarianChecked,
                      onChanged: (newBool) {
                        setState(() {
                          isVegetarianChecked = newBool;
                        });
                      }),
                  const Text("Vegetarian")
                ],
              ),
              Row(
                children: [
                  Checkbox(
                      value: isGlutenfreeChecked,
                      onChanged: (newBool) {
                        setState(() {
                          isGlutenfreeChecked = newBool;
                        });
                      }),
                  const Text("Glutenfree")
                ],
              ),
              SizedBox(
                width: 100,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    final name = titleName.text;
                    final description = titleDescription.text;
                    final cookTime = titleCookTime.text;
                    createRecepe(
                      name: name,
                      descriptions: description,
                      time: cookTime,
                      thumbnailUrl: thumbnailUrl,
                    );

                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Saving recipe"),
                        content: const Text("Your recipe is saved"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                              Navigator.pop(context, true);
                            },
                            child: Container(
                              color: Colors.green,
                              padding: const EdgeInsets.all(14),
                              child: const Text("OK"),
                            ),
                          ),
                        ],
                      ),
                    );

                    child:
                    const Text("Show alert Dialog box");
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
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      IconButton(
        onPressed: () {
          pickImage();
        },
        color: Colors.orange,
        icon: Icon(icon),
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
          labelText: "Description",
          labelStyle: const TextStyle(color: Colors.orange),
        ),
      );

  File? image;
  PlatformFile? pickedImage;

  Future pickImage() async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 75);
      if (image == null) return;

      final fileName = "files/${image.path}";
      Reference ref = FirebaseStorage.instance.ref().child(fileName);
      await ref.putFile(File(image.path));
      ref.getDownloadURL().then((value) {
        print(value);

        setState(() {
          thumbnailUrl = value;
        });
      });

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  Stream<List<_addRecipesState>> readUsers() => FirebaseFirestore.instance
      .collection("Recipe")
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => _addRecipesState.fromJson(doc.data()))
          .toList());

  Future<dynamic> createRecepe(
      {required String name,
      required String descriptions,
      required String time,
      required String thumbnailUrl}) async {
    final docUser = FirebaseFirestore.instance.collection("Recipes").doc();
    FirebaseAuth auth = FirebaseAuth.instance;
    String userUid = auth.currentUser!.uid.toString();

    final recipe = _addRecipesState(
        id: docUser.id,
        thumbnailUrl: thumbnailUrl,
        title: name,
        cookTime: time,
        description: descriptions,
        isGlutenfreeChecked: isGlutenfreeChecked,
        isLactoseFreeChecked: isLactoseFreeChecked,
        isVegetarianChecked: isVegetarianChecked);
    final recipesData = recipe.toJson();

    await docUser.set(recipesData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipe App"),
      ),
      body:  Container(
        child: SingleChildScrollView(
          child: buildTextFields(),
        ),
      ),
    );
  }
}
