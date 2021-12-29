class AdModel {
  String image;
  String url;
  String title;

  AdModel.fromJson(dynamic json) {
    url = json['url'];
    image = json['image'];
    title = json['title'];
  }
}
