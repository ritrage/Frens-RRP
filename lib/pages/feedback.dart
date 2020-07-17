import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ritrageindiacalls/models/feed.dart';

class FeedbackPage extends StatefulWidget {
  final String uid;

  const FeedbackPage({Key key, this.uid}) : super(key: key);
  @override
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<FeedbackPage> {
  final _channelController = TextEditingController();
  bool _validateError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.blue,
        title: new Text("Frens: Support"),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 400,
          child: Column(
            children: <Widget>[
              Container(
                child: TextField(
                  controller: _channelController,
                  decoration: InputDecoration(
                    errorText: _validateError ? 'Please enter feedback' : null,
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1),
                    ),
                    hintText: 'Feedback',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    padding: EdgeInsets.all(15),
                    onPressed: sendFeedback,
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text(
                      "Send Feedback",
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

  Future<void> sendFeedback() async {
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      Feed feed = Feed(
        uid: widget.uid,
        feedbackData: _channelController.text,
      );
      final Firestore firestore = Firestore.instance;
      await firestore
          .collection("FeedBacks")
          .document(feed.uid)
          .setData(feed.toMap(feed));
      Fluttertoast.showToast(
        msg: "Feedback Sent. We will try to process it as soon as possible.",
        backgroundColor: Colors.yellow,
      );
      Navigator.pop(context);
    }
  }
}
