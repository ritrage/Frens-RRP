import 'package:flutter/cupertino.dart';

class UserCreds {
  @required
  String meetId;
  @required
  String passCode;
  UserCreds({
    this.meetId,
    this.passCode,
});

  Map toMap(UserCreds userCreds) {
    var data = Map<String, dynamic>();
    data['meetId'] = userCreds.meetId;
    data['passCode'] = userCreds.passCode;
    return data;
  }

  UserCreds.fromMap(Map<String, dynamic> mapData) {
    this.meetId = mapData['meetId'];
    this.passCode = mapData['passCode'];
  }
}