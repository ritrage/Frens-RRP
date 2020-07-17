import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ritrageindiacalls/components/home_page_contents.dart';
import 'package:ritrageindiacalls/components/user_info_display.dart';
import 'package:ritrageindiacalls/functionalities/firebase_repository.dart';
import 'package:ritrageindiacalls/main.dart';
import 'package:ritrageindiacalls/pages/feedback.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:ritrageindiacalls/functionalities/admob_services.dart';

const String device = 'Mobile_Id';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final ams = AdMobService();

  final FirebaseRepository repository = FirebaseRepository();
  FirebaseUser firebaseUser;
  @override
  void initState() {
    super.initState();
    initialize();
    Admob.initialize(ams.getAdMobAppId());
  }

  Future<void> initialize() async {
    await repository.getCurrentUser().then((user) {
      setState(() {
        firebaseUser = user;
      });
    });
  }




//  void getCurrent() async {
//    firebaseUser = await _auth.currentUser();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.blue,
        title: new Text("Frens"),
        actions: <Widget>[
          IconButton(
            icon: CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(firebaseUser.photoUrl),
              //(firebaseUser.photoUrl!=null) ? NetworkImage(firebaseUser.photoUrl) : Icons.account_circle,
              backgroundColor: Colors.transparent,
            ),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(firebaseUser.displayName),
              accountEmail: Text(firebaseUser.email),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(firebaseUser.photoUrl),
                  //(firebaseUser.photoUrl!=null) ? NetworkImage(firebaseUser.photoUrl) : Icons.account_circle,
                  backgroundColor: Colors.transparent,
                ),
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
//            InkWell(
//              onTap: () {},
//              child: ListTile(
//                title: Text('Schedule a Meet'),
//                leading: Icon(Icons.calendar_today),
//              ),
//            ),
//            // InkWell(
//            //   onTap: () {},
//            //   child: ListTile(
//            //     title: Text('Set a Reminder'),
//            //     leading: Icon(Icons.schedule),
//            //   ),
//            // ),
//            Divider(),
            AdmobBanner(
              adUnitId: ams.getBannerAdId(),
              adSize: AdmobBannerSize.MEDIUM_RECTANGLE,
            ),
            InkWell(
              onTap: () async {
                await repository.signOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyApp(),
                    ));
              },
              child: ListTile(
                title: Text('Sign Out'),
                leading: Icon(Icons.exit_to_app),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: UserDisplay(),
            ),
            Divider(),
            Flexible(child: HomePageContents()),
//            AdmobBanner(
//              adUnitId: ams.getBannerAdId(),
//              adSize: AdmobBannerSize.FULL_BANNER,
//            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FeedbackPage(
                  uid: firebaseUser.uid,
                ),
              ));
        },
        elevation: 1.0,
        child: Icon(
          Icons.headset_mic,
          size: 40,
        ),
      ),
    );
  }
}
