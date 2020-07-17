class Feed {
  String uid;
  String feedbackData;

  Feed({
    this.uid,
    this.feedbackData,
  });

  Map toMap(Feed feeba) {
    var data = Map<String, dynamic>();
    data['uid'] = feeba.uid;
    data['feebackData'] = feeba.feedbackData;
    return data;
  }

  Feed.fromMap(Map<String, dynamic> mapData) {
    this.feedbackData = mapData['feedbackData'];
    this.uid = mapData['uid'];
  }
}
