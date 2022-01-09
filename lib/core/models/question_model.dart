class QuestionModel {
  String answer;
  String question;
  String updatedAt;
  String scheduledAt;
  String uid;
  String id;
  String createdAt;
  String category;
  String story;

  QuestionModel.fromJson(dynamic json) {
    question = json['question'];
    answer = json['answer'];
    id = json['id'];
    uid = json['uid'];
    createdAt = json['created_at'] ?? json['create_at'] ;
    category = json['category'];
    updatedAt = json['updated_at'];
    scheduledAt = json['scheduled_at'] == null ? 'empty' : json['scheduled_at'];
    story = json['story'];
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
    data['scheduled_at'] = scheduledAt;
    data['story'] = story;
    return data;
  }
}
