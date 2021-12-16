class WinnerModel {
  String name;
  String amount;
  String updatedAt;
  String uid;
  String id;
  String createdAt;
  int position;
  String story;

  WinnerModel.fromJson(dynamic json) {
    amount = json['amount'];
    name = json['name'];
    id = json['id'];
    uid = json['uid'];
    createdAt = json['created_at'];
    position = json['position'];
    updatedAt = json['updated_at'];
    story = json['story'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['name'] = name;
    data['id'] = id;
    data['uid'] = uid;
    data['created_at'] = createdAt;
    data['position'] = position;
    data['updated_at'] = updatedAt;
    data['story'] = story;
    return data;
  }
}