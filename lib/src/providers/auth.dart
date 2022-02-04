import 'dart:convert';

import 'package:delivery_application/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

class Auth with ChangeNotifier {
  String _token = "";
  bool _isAuth = false;

  String get token {
    return _token;
  }

  set token(String token) {
    _token = token;

    notifyListeners();
  }

  bool get isAuth {
    return _isAuth;
  }

  set isAuth(bool isAuth) {
    _isAuth = isAuth;

    notifyListeners();
  }

  void logout() {
    _isAuth = false;
    _token = "";

    notifyListeners();
  }

  void login(String token) {
    const options = IOSOptions(
      accessibility: IOSAccessibility.first_unlock,
    );
    storage.write(
      key: "jwt",
      value: token,
      iOptions: options,
    );
    _token = token;
    _isAuth = true;

    notifyListeners();
  }

  User currentUser() {
    if (_token.isEmpty) {
      return User();
    }
    var response = json.decode(
        ascii.decode(base64.decode(base64.normalize(_token.split(".")[1]))));

    return User(
        id: response['id'],
        username: response['username'],
        email: response['email'],
        password: response['password']);
  }
}
