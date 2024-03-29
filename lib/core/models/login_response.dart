class UserData {
  int updatedAt;
  int createdAt;
  int lastTimeWon;
  String email;
  String address;
  String ig;
  String dateOfBirth;
  String plan;
  String name;
  String phone;
  String type;
  String uid;
  String image;
  String chipperTag;
  String status;

  UserData(
      {this.plan,
      this.email,
      this.updatedAt,
      this.name,
      this.phone,
      this.type,
      this.uid,
      this.status,
      this.address,
      this.ig,
      this.dateOfBirth,
      this.image,
      this.lastTimeWon,
      this.chipperTag,
      this.createdAt});

  UserData.fromJson(dynamic json) {
    plan = json['plan'];
    email = json['email'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    name = json['name'];
    address = json['address'];
    ig = json['ig'];
    dateOfBirth = json['dateOfBirth'];
    phone = json['phone'];
    uid = json['uid'];
    type = json['type'];
    image = json['image'];
    chipperTag = json['chipper_tag'] ?? '';
    lastTimeWon = json['last_time_won'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['plan'] = this.plan;
    data['email'] = this.email;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['name'] = this.name;
    data['address'] = this.address;
    data['ig'] = this.ig;
    data['dateOfBirth'] = this.dateOfBirth;
    data['type'] = this.type;
    data['phone'] = this.phone;
    data['uid'] = this.uid;
    data['chipper_tag'] = this.chipperTag;
    data['status'] = this.status;
    data['last_time_won'] = this.lastTimeWon;
    data['image'] = this.image;
    return data;
  }
}
