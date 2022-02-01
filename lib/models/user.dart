class User {
  int? id;
  String? name;
  String? user;
  String? password;
  String? email;

  User({this.id, this.name, this.user, this.password, this.email});

  User.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    user = json['User'];
    password = json['Password'];
    email = json['Email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['User'] = user;
    data['Password'] = password;
    data['Email'] = email;
    return data;
  }
}