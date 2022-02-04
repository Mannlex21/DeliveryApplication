class User {
  int? id;
  String? username;
  String? password;
  String? email;

  User({this.id, this.username, this.password, this.email});

  User.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    username = json['User'];
    password = json['Password'];
    email = json['Email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['User'] = username;
    data['Password'] = password;
    data['Email'] = email;
    return data;
  }
}
