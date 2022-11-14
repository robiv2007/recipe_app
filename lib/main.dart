import './pages/addRecipe.dart';
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
  runApp(const MyApp());
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
      home: const WidgetTree(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipeee"),
      ),
      body: Center(
        child: Text("Favorites"),
      ),
    );
  }
}

// void _addRecipeBottomSheet(context) {
//   showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//             height: MediaQuery.of(context).size.height * .60,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text("Test"),
//             ));
//       });
// }
