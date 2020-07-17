import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ritrageindiacalls/src/pages/call.dart';
import 'package:ritrageindiacalls/src/pages/index.dart';
import 'package:ritrageindiacalls/src/pages/start_index.dart';

class HomePageContents extends StatefulWidget {
  @override
  _HomePageContentsState createState() => _HomePageContentsState();
}

class _HomePageContentsState extends State<HomePageContents> {
  @override
  Widget build(BuildContext context) {
    return Container(alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(20,0,20,5),
            child: SizedBox(
              width: double.infinity ,
              child: RaisedButton(
                padding: EdgeInsets.all(20),
                onPressed: startMeet,
                textColor: Colors.white,
                color: Colors.blue,
                child: Text(
                  "Start Meeting",
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
          Container(
            margin: EdgeInsets.fromLTRB(20,5,20,0),
            child: SizedBox(
              width: double.infinity ,
              child: RaisedButton(
                padding: EdgeInsets.all(20),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return IndexPage();
                      }
                  ));
                },
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
    );
  }

  Future<void> startMeet() async {
    String channelName = await generateChannelName();
    await _handleCameraAndMic();
    await Navigator.push(context, MaterialPageRoute(
      builder: (context)=> StartIndex(
        channelName: channelName,
      ),
    ));
  }

  Future<String> generateChannelName() async {
    String AlphaNumericString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz";
    String channelName = "";
    int n=8;
    var indexes = List.generate(n, (index)=>Random.secure().nextInt(62));
    for(int i=0; i<n; i++) {
      int ind = indexes.elementAt(i);
      channelName += AlphaNumericString[ind];
    }
    return channelName;
  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }
}


//class HomePageContents extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      alignment: Alignment.center,
//      child: Column(
//        mainAxisAlignment: MainAxisAlignment.start,
//        children: <Widget>[
//          Container(
//            margin: EdgeInsets.fromLTRB(20,0,20,5),
//            child: SizedBox(
//              width: double.infinity ,
//              child: RaisedButton(
//                padding: EdgeInsets.all(20),
//                onPressed: () {startMeet();},
//                textColor: Colors.white,
//                color: Colors.blue,
//                child: Text(
//                  "Start Meeting",
//                  style: TextStyle(
//                    fontFamily: 'Montserrat',
//                    fontSize: 16,
//                    fontWeight: FontWeight.w600,
//                    letterSpacing: 1,
//                  ),
//                ),
//                shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(500),
//                ),
//              ),
//            ),
//          ),
//          Container(
//            margin: EdgeInsets.fromLTRB(20,5,20,0),
//            child: SizedBox(
//              width: double.infinity ,
//              child: RaisedButton(
//                padding: EdgeInsets.all(20),
//                onPressed: () {
//                  Navigator.of(context).push(MaterialPageRoute(
//                    builder: (context) {
//                      return IndexPage();
//                    }
//                  ));
//                },
//                textColor: Colors.white,
//                color: Colors.blue,
//                child: Text(
//                  "Join Meeting",
//                  style: TextStyle(
//                    fontFamily: 'Montserrat',
//                    fontSize: 16,
//                    fontWeight: FontWeight.w600,
//                    letterSpacing: 1,
//                  ),
//                ),
//                shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(500),
//                ),
//              ),
//            ),
//          ),
//        ],
//      ),
//    );
//
////    return Container(
////        child: GridView(
////      gridDelegate:
////          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
////      children: <Widget>[
////        Card(
////          child: Hero(
////            tag: new Text("StartMeeting"),
////            child: Material(
////              color: Colors.blue[800],
////              child: InkWell(
////                onTap: () {},
////                child: GridTile(
////                  footer: Container(
////                    color: Colors.white70,
////                    child: ListTile(
////                      title: Text(
////                        "Start Meeting",
////                        style: TextStyle(fontWeight: FontWeight.w500),
////                      ),
////                    ),
////                  ),
////                  child: IconButton(
////                    icon: Icon(
////                      Icons.group_add,
////                      size: 170,
////                      color: Colors.white,
////                    ),
////                    onPressed: (){},
////                  ),
////                  //child: new Text("lol"),
////                ),
////              ),
////            ),
////          ),
////        ),
////        Card(
////          child: Hero(
////            tag: new Text("JoinMeeting"),
////            child: Material(
////              color: Colors.blue[800],
////              child: InkWell(
////                onTap: () {},
////                child: GridTile(
////                  footer: Container(
////                    color: Colors.white70,
////                    child: ListTile(
////                      title: Text(
////                        "Join Meeting",
////                        style: TextStyle(fontWeight: FontWeight.w500),
////                      ),
////                    ),
////                  ),
////                  child: IconButton(
////                    icon: Icon(
////                      Icons.group,
////                      size: 150,
////                      color: Colors.white,
////                    ),
////                    onPressed: (){},
////                  ),
////                ),
////              ),
////            ),
////          ),
////        ),
////        Card(
////          child: Hero(
////            tag: new Text("ScheduleMeeting"),
////            child: Material(
////              color: Colors.blue[800],
////              child: InkWell(
////                onTap: () {},
////                child: GridTile(
////                  footer: Container(
////                    color: Colors.white70,
////                    child: ListTile(
////                      title: Text(
////                        "Schedule a Meet",
////                        style: TextStyle(fontWeight: FontWeight.w500),
////                      ),
////                    ),
////                  ),
////                  child: IconButton(
////                    icon: Icon(
////                      Icons.schedule,
////                      size: 140,
////                      color: Colors.white,
////                    ),
////                    onPressed: (){},
////                  ),
////                ),
////              ),
////            ),
////          ),
////        ),
////        Card(
////          child: Hero(
////            tag: new Text("Contacts"),
////            child: Material(
////              color: Colors.blue[800],
////              child: InkWell(
////                onTap: () {},
////                child: GridTile(
////                  footer: Container(
////                    color: Colors.white70,
////                    child: ListTile(
////                      title: Text(
////                        "Contacts",
////                        style: TextStyle(fontWeight: FontWeight.w500),
////                      ),
////                    ),
////                  ),
////                  child: IconButton(
////                    icon: Icon(
////                      Icons.contact_phone,
////                      size: 150,
////                      color: Colors.white,
////                    ),
////                    onPressed: (){},
////                  ),
////                ),
////              ),
////            ),
////          ),
////        ),
////        Card(
////          child: Hero(
////            tag: new Text("Settings"),
////            child: Material(
////              color: Colors.blue[800],
////              child: InkWell(
////                onTap: () {},
////                child: GridTile(
////                  footer: Container(
////                    color: Colors.white70,
////                    child: ListTile(
////                      title: Text(
////                        "Settings",
////                        style: TextStyle(fontWeight: FontWeight.w500),
////                      ),
////                    ),
////                  ),
////                  child: IconButton(
////                    icon: Icon(
////                      Icons.settings,
////                      size: 150,
////                      color: Colors.white,
////                    ),
////                    onPressed: (){},
////                  ),
////                ),
////              ),
////            ),
////          ),
////        ),
////        Card(
////          child: Hero(
////            tag: new Text("Help"),
////            child: Material(
////              color: Colors.blue[800],
////              child: InkWell(
////                onTap: () {},
////                child: GridTile(
////                  footer: Container(
////                    color: Colors.white70,
////                    child: ListTile(
////                      title: Text(
////                        "Help",
////                        style: TextStyle(fontWeight: FontWeight.w500),
////                      ),
////                    ),
////                  ),
////                  child: IconButton(
////                    icon: Icon(
////                      Icons.help,
////                      size: 150,
////                      color: Colors.white,
////                    ),
////                    onPressed: (){},
////                  ),
////                ),
////              ),
////            ),
////          ),
////        ),
////      ],
////    ));
//  }
//
//
//}

