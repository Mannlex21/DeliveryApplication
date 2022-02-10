import 'package:delivery_application/models/users_details.dart';

class User {
  int? id;
  String? username;
  String? email;
  UserDetails? userDetails;

  User({this.id, this.username, this.email, this.userDetails});

  User.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    username = json['User'];
    email = json['Email'];
    userDetails = UserDetails.fromJson(json['details']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['User'] = username;
    data['Email'] = email;
    data['Details'] = userDetails;
    return data;
  }
}
