import 'package:delivery_application/models/error.dart';

class Response<T> {
  bool success = true;
  bool failure = false;
  T? value;
  List<Error>? errorList;

  Response(
      {required this.success,
      required this.failure,
      this.value,
      this.errorList});

  Response.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    failure = json['failure'];
    value = json['value'];
    errorList = json['errorList'] != null
        ? (json['errorList'] as List)
            .map<Error>((item) => Error.fromJson(item))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['failure'] = failure;
    data['value'] = value;
    data['errorList'] = errorList;
    return data;
  }
}
