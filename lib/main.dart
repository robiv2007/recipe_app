import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recipe_app/pages/home_page.dart';
import 'package:recipe_app/pages/login_register_page.dart';
import 'firebase_options.dart';
import 'cardView.dart';
import 'package:recipe_app/widget_tree.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: LoginPage(), //const MyHomePage(title: 'Recipe Spot')
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
          padding: EdgeInsets.all(16),
          itemBuilder: (context, index) {
            return RecipeCard(
              title: "pizza",
              cookTime: "40",
              rating: "8",
              thumbnailUrl: "",
            );
          },
        )
        // floatingActionButton: FloatingActionButton(
        //   onPressed: {},
        //   tooltip: 'Increment',
        //   child: const Icon(Icons.add),
        // ),
        );
  }
}
