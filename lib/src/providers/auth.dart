import 'dart:convert';
import 'package:delivery_application/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../models/response.dart';

const storage = FlutterSecureStorage();

class Auth with ChangeNotifier {
  String _token = "";
  bool _isAuth = false;
  User? _user;

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

  set user(User? user) {
    _user = user;

    notifyListeners();
  }

  User? get user {
    return _user;
  }

  void logout() {
    _isAuth = false;
    _token = "";
    _user = null;

    notifyListeners();
  }

  Future<bool> login(String token) async {
    const options = IOSOptions(
      accessibility: IOSAccessibility.first_unlock,
    );
    storage.write(
      key: "jwt",
      value: token,
      iOptions: options,
    );
    var result = await currentUser(token).then((value) {
      if (value != null) {
        _token = token;
        _isAuth = true;
        _user = value;

        notifyListeners();
        return true;
      } else {
        return false;
      }
    });
    return result;
  }

  Future<User?> currentUser(String token) async {
    if (token.isEmpty) {
      return null;
    } else {
      var request = await http.get(
          Uri.parse('http://192.168.1.64:9090/client/currentUser'),
          headers: {
            'Authorization': 'Bearer $token',
          });
      var result = Response.fromJson(jsonDecode(request.body.toString()));
      return result.success ? User.fromJson(result.value) : null;
    }
  }
}
