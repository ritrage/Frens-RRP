import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class UserDisplay extends StatefulWidget {
  @override
  _UserDisplayState createState() => _UserDisplayState();
}

class _UserDisplayState extends State<UserDisplay> {
  @override
  Widget build(BuildContext context) {
    Widget carousel = new Container(
      height: 200.0,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage("assets/images/makeInIndia.jpeg")
        ],
        autoplay: true,
        animationCurve: Curves.easeInOutBack,
        animationDuration: Duration(seconds: 1),
        dotSize: 0,
        indicatorBgPadding: 2,
      ),
    );
    return carousel;
//    return Container(
//      color: Colors.green,
//      child: ListTile(
////        leading: Image.asset(),
//        leading: IconButton(
//          icon: new Icon(Icons.account_circle, color: Colors.black,),
//        ),
//        title: new Text("Ritwik Sharma",style: TextStyle(fontWeight: FontWeight.w600),),
//      ),
//    );
  }
}
