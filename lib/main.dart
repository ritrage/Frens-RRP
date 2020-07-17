import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ritrageindiacalls/functionalities/firebase_repository.dart';
import 'package:ritrageindiacalls/pages/login.dart';
import 'package:ritrageindiacalls/pages/home.dart';

void main() {
  runApp(
      MyApp()
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  FirebaseRepository _repository = FirebaseRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: _repository.getCurrentUser(),
        builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
          if(snapshot.hasData) {
            return Home();
          }
          else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
