class UserData {
  int? updatedAt;
  int? createdAt;
  int? lastTimeWon;
  String? email;
  String? address;
  String? plan;
  String? name;
  String? phone;
  String? type;
  String? uid;
  String? image;
  String? status;

  UserData(
      {this.plan,
      this.email,
      this.updatedAt,
      this.name,
      this.phone,
      this.type,
      this.uid,
      this.status,
      this.address,this.lastTimeWon,
      this.image,
      this.createdAt});

  UserData.fromJson(dynamic json) {
    plan = json['plan'];
    email = json['email'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    uid = json['uid'];
    type = json['type'];
    lastTimeWon = json['last_time_won'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['plan'] = this.plan;
    data['last_time_won'] = this.lastTimeWon;
    data['email'] = this.email;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['name'] = this.name;
    data['address'] = this.address;
    data['type'] = this.type;
    data['phone'] = this.phone;
    data['uid'] = this.uid;
    data['status'] = this.status;
    data['image'] = this.image;
    return data;
  }
}
