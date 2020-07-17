import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ritrageindiacalls/functionalities/firebase_repository.dart';
import 'package:ritrageindiacalls/pages/home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseRepository _repository = FirebaseRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.blue,
        title: new Text("Frens"),
      ),
      body: loginButton(),
    );
  }

  Widget loginButton() {
    return Container(
      //color: Colors.grey[800],
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/CompanyLogo.jpeg"),
        fit: BoxFit.cover,
      )),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 100),
            child: SizedBox(
              width: double.infinity,
              child: RaisedButton(
                padding: EdgeInsets.all(20),
                onPressed: () {
                  performLogin();
                },
                textColor: Colors.white,
                color: Colors.blue,
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(500),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void performLogin() {
    _repository.signIn().then((FirebaseUser user) {
      if (user != null) {
        authenticateUser(user);
      } else {
        print("There was an error");
      }
    });
  }

  void authenticateUser(FirebaseUser user) {
    _repository.authenticateUser(user).then((isNewUser) {
      if (isNewUser) {
        _repository.addDataToDb(user).then((value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return Home();
          }));
        });
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return Home();
        }));
      }
    });
  }
}
