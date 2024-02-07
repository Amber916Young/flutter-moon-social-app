class SignUpModel {
  int? _id;
  String? _firstName;
  String? _lastName;
  String? _username;
  String? _email;
  String? _phone;
  String? _password;
  String? _dateOfBirth;

  SignUpModel({int? id, String? username, String? firstName, String? lastName, String? email, String? phone, String? password, String? dateOfBirth}) {
    if (id != null) {
      _id = id;
    }
    if (username != null) {
      _username = username;
    }
    if (firstName != null) {
      _firstName = firstName;
    }
    if (lastName != null) {
      _lastName = lastName;
    }
    if (email != null) {
      _email = email;
    }
    if (phone != null) {
      _phone = phone;
    }
    if (password != null) {
      _password = password;
    }
    if (dateOfBirth != null) {
      _dateOfBirth = dateOfBirth;
    }
  }

  int? get id => _id;

  set id(int? id) => _id = id;

  String? get username => _username;

  set username(String? username) => _username = username;

  String? get firstName => _firstName;

  set firstName(String? firstName) => _firstName = firstName;

  String? get lastName => _lastName;

  set lastName(String? lastName) => _lastName = lastName;

  String? get email => _email;

  set email(String? email) => _email = email;

  String? get phone => _phone;

  set phone(String? phone) => _phone = phone;

  String? get password => _password;

  set password(String? password) => _password = password;

  String? get dateOfBirth => _dateOfBirth;

  set dateOfBirth(String? dateOfBirth) => _dateOfBirth = dateOfBirth;

  SignUpModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _username = json['username'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _email = json['email'];
    _phone = json['phone'];
    _password = json['password'];
    _dateOfBirth = json['dateOfBirth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = _id;
    data['username'] = _username;
    data['firstName'] = _firstName;
    data['lastName'] = _lastName;
    data['email'] = _email;
    data['phone'] = _phone;
    data['password'] = _password;
    data['dateOfBirth'] = _dateOfBirth;
    return data;
  }
}
