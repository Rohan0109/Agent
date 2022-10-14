// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    required this.phoneNumber,
    required this.isAuthorized,
    required this.createAt,
    required this.isActive,
    required this.id,
    required this.country,
    required this.district,
    required this.email,
    required this.name,
    required this.state,
    required this.subWard,
    required this.taluk,
    required this.ward,
  });

  String phoneNumber;
  bool isAuthorized;
  DateTime createAt;
  bool isActive;
  int id;
  String country;
  String district;
  String email;
  String name;
  String state;
  String subWard;
  String taluk;
  String ward;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        phoneNumber: json["phoneNumber"],
        isAuthorized: json["isAuthorized"],
        createAt: DateTime.parse(json["createAt"]),
        isActive: json["isActive"],
        id: json["id"],
        country: json["country"],
        district: json["district"],
        email: json["email"],
        name: json["name"],
        state: json["state"],
        subWard: json["subWard"],
        taluk: json["taluk"],
        ward: json["ward"],
      );

  Map<String, dynamic> toJson() => {
        "phoneNumber": phoneNumber,
        "isAuthorized": isAuthorized,
        "createAt":
            "${createAt.year.toString().padLeft(4, '0')}-${createAt.month.toString().padLeft(2, '0')}-${createAt.day.toString().padLeft(2, '0')}",
        "isActive": isActive,
        "id": id,
        "country": country,
        "district": district,
        "email": email,
        "name": name,
        "state": state,
        "subWard": subWard,
        "taluk": taluk,
        "ward": ward,
      };
}
