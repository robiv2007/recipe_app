import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _title() {
    return const Text('');
  }

  Widget _entryFieldEmail(
    String title,
    TextEditingController _controllerEmail,
  ) {
    return TextField(
      controller: _controllerEmail,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.mail),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(5),
        border: UnderlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: title,
      ),
    );
  }

  Widget _entryFieldPassword(
    String title,
    TextEditingController _controllerPassword,
  ) {
    return TextField(
      controller: _controllerPassword,
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.key),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(5),
        border: UnderlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: title,
      ),
    );
  }

  Widget _errorMessage() {
    return Text(
      errorMessage == '' ? '' : '$errorMessage',
      style: const TextStyle(color: Colors.white, fontSize: 14),
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed:
          isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      style: ElevatedButton.styleFrom(fixedSize: const Size(150, 30)),
      child: Text(isLogin ? 'Login' : 'Register'),
    );
  }

  Widget _loginOrRegisterButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[300], fixedSize: const Size(150, 30)),
      child: Text(isLogin ? 'Register instead' : 'Login instead'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1615719413546-198b25453f85?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=436&q=80'),
              fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Vesuvio",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 70,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            _entryFieldEmail('email', _controllerEmail),
            const SizedBox(
              height: 5,
            ),
            _entryFieldPassword('password', _controllerPassword),
            const SizedBox(
              height: 10,
            ),
            _errorMessage(),
            const SizedBox(
              height: 10,
            ),
            _submitButton(),
            _loginOrRegisterButton(),
          ],
        ),
      ),
    );
  }
}
