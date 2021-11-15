// To parse this JSON data, do
//
//     final userAuthModel = userAuthModelFromJson(jsonString);

import 'dart:convert';

UserAuthModel userAuthModelFromJson(String str) =>
    UserAuthModel.fromJson(json.decode(str));

String userAuthModelToJson(UserAuthModel data) => json.encode(data.toJson());

class UserAuthModel {
  UserAuthModel({
     this.firstName,
     this.lastName,
    required this.email,
    required this.password,
     this.passwordConfirmation,
  });

  String? firstName;
  String? lastName;
  String email;
  String password;
  String? passwordConfirmation;

  factory UserAuthModel.fromJson(Map<String, dynamic> json) => UserAuthModel(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        password: json["password"],
        passwordConfirmation: json["password_confirmation"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
      };

       Map<String, dynamic> loginToJson() => {
        "email": email,
        "password": password,
      };
}
