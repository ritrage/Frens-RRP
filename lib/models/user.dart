class User {
  String uid;
  String name;
  String email;
  String username;
  String profilePhoto;

  User({
    this.uid,
    this.name,
    this.email,
    this.username,
    this.profilePhoto,
});
  Map toMap(User user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['name'] = user.name;
    data['email'] = user.email;
    data['username'] = user.username;
    data['profile_photo'] = user.profilePhoto;
    return data;
  }

  User.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.name = mapData['name'];
    this.email = mapData['email'];
    this.username = mapData['username'];
    this.profilePhoto = mapData['profile_photo'];
  }


}