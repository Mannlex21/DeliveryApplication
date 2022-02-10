class UserDetails {
  String? firstName;
  String? lastName;
  String? areaCode;
  String? phoneNumber;

  UserDetails({this.firstName, this.lastName, this.areaCode, this.phoneNumber});

  UserDetails.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    areaCode = json['areaCode'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    data['AreaCode'] = areaCode;
    data['PhoneNumber'] = phoneNumber;
    return data;
  }
}
