class NameModel {
  String? name;

  NameModel({this.name});

  NameModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =
        new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
