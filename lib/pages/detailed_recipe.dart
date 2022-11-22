import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/cardView.dart';
import 'package:recipe_app/main.dart';
import '../auth.dart';
import 'addRecipe.dart';
import 'recipe_overview_screen.dart';


class SecondRoute extends StatelessWidget {

   String text;
   String text2;
   String text3;
   String text4;
   SecondRoute({Key? key,required this.text, required this.text2, required this.text3, required this.text4}) : super(key: key);

@override
  Widget build(BuildContext context) { 
    return Scaffold(
            appBar: AppBar(
        
      ),
      
    body: Center(
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                height: 200.0,
                image: NetworkImage(text3),        
              ),
            ),
            const SizedBox(height: 30),
            Container(
                width: 600,
                height: 70,
                decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black,
                    width: 5,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                    new BoxShadow(
                    color: Colors.grey,
                    offset: new Offset(10.0, 10.0),
                    ),
                ],
                ),
                child: Center(
                child: Text("$text", style: TextStyle(fontSize: 20))
                ),
            ),
            const SizedBox(height: 30),
	        Container(
                width: 800,
                height: 100,
                decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black,
                    width: 5,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                    new BoxShadow(
                    color: Colors.grey,
                    offset: new Offset(10.0, 10.0),
                    ),
                ],
                ),
                child: Center(
                child: Text("$text2", style: TextStyle(fontSize: 20))
                ),
            ),
            const SizedBox(height: 30),
            Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black,
                    width: 5,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                    new BoxShadow(
                    color: Colors.grey,
                    offset: new Offset(10.0, 10.0),
                    ),
                ],
                ),
                child: Center(
                child: Text("CookTime : $text4 min", style: TextStyle(fontSize: 20))
                ),
            ),
            Text("$text3"),
            MyStatelessWidget(        
            ),
          ],
        ),
      ),
    ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});


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
          content: const Text('Do you want to save this recipe to your favourites?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
                onPressed: () {
                    Navigator.pop(context, 'Save');
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
