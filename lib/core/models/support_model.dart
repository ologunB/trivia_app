class SupportModel {
  String from;
  String desc;
  String status;
  int updatedAt;
  String id;
  String loadId;
  String reply;
  String uid;

  SupportModel({
    this.from,
    this.updatedAt,
    this.status,
    this.id,
    this.uid,
    this.loadId,
    this.reply,
    this.desc,
  });

  SupportModel.fromJson(dynamic json) {
    status = json['status'];
    from = json['from'];
    id = json['id'];
    uid = json['uid'];
    loadId = json['load_id'];
    desc = json['desc'];
    reply = json['reply'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['from'] = this.from;
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['load_id'] = this.loadId;
    data['desc'] = this.desc;
    data['status'] = this.status;
    data['reply'] = this.reply;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
