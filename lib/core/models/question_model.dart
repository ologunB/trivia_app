class QuestionModel {
  String answer;
  String question;
  String updatedAt;
  String uid;
  String id;
  String createdAt;
  String category;
  String story;
  bool isRead;

  QuestionModel.fromJson(dynamic json) {
    question = json['question'];
    answer = json['answer'];
    id = json['id'];
    uid = json['uid'];
    createdAt = json['created_at'];
    category = json['category'];
    updatedAt = json['updated_at'];
    story = json['story'];
    isRead = json['is_read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    data['answer'] = answer;
    data['id'] = id;
    data['uid'] = uid;
    data['created_at'] = createdAt;
    data['category'] = category;
    data['updated_at'] = updatedAt;
    data['story'] = story;
    data['is_read'] = isRead;
    return data;
  }
}
