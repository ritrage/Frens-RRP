import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ritrageindiacalls/models/userCreds.dart';

import './call.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<IndexPage> {
  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();
  final _passwordController = TextEditingController();

  /// if channel textField is validated to have error
  bool _validateError = false;
  bool _validatePassword = false;

  @override
  void dispose() {
    _channelController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Frens'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 400,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _channelController,
                      decoration: InputDecoration(
                        errorText:
                            _validateError ? 'Meeting Id is mandatory' : null,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                        hintText: 'Meeting Id',
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        errorText: _validatePassword
                            ? 'Meeting Password is mandatory'
                            : null,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                        hintText: 'Meeting Password',
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    padding: EdgeInsets.all(15),
                    onPressed: onJoin,
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text(
                      "Join Meeting",
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
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    // update input validation
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
      _passwordController.text.isEmpty
          ? _validatePassword = true
          : _validatePassword = false;
    });
    if (_channelController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      await _handleCameraAndMic();
      bool answer =
          await checkCreds(_channelController.text, _passwordController.text);
      if (answer == true) {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CallPage(
              channelName: _channelController.text,
              passCode: _passwordController.text,
            ),
          ),
        );
      } else {
        Fluttertoast.showToast(
            msg: "Wrong Meeting Id or Password",
            backgroundColor: Colors.red,
            textColor: Colors.white);
      }
    }
  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }

  Future<bool> checkCreds(String meetId, String password) async {
    UserCreds userCreds = UserCreds(
      meetId: meetId,
      passCode: password,
    );
    Firestore firestore = Firestore.instance;
    QuerySnapshot result = await firestore
        .collection("Meetings")
        .where("meetId", isEqualTo: userCreds.meetId)
        .where("passCode", isEqualTo: userCreds.passCode)
        .getDocuments();

    final List<DocumentSnapshot> docs = result.documents;
    if (docs.length == 0) return false;
    return true;
  }
}
