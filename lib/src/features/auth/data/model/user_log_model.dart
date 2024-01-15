class UserLogModel {
  String? countryCode;
  String? phoneNumber;
  String? email;
  String? password;

  UserLogModel({this.countryCode, this.phoneNumber, this.email, this.password});

  UserLogModel.fromJson(Map<String, dynamic> json) {
    countryCode = json['country_code'];
    phoneNumber = json['phone_number'];
    password = json['password'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country_code'] = countryCode;
    data['phone_number'] = phoneNumber;
    data['password'] = password;
    data['email'] = email;
    return data;
  }
}
