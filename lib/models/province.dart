// To parse this JSON data, do
//
//     final province = provinceFromJson(jsonString);

import 'dart:convert';

List<Province> provinceFromJson(String str) =>
    List<Province>.from(json.decode(str).map((x) => Province.fromJson(x)));

String provinceToJson(List<Province> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Province {
  Province({
    required this.createdAt,
    required this.code,
    required this.stateName,
    required this.type,
    required this.countryId,
    required this.updatedAt,
    required this.id,
  });

  int createdAt;
  int code;
  StateName stateName;
  String type;
  int countryId;
  int updatedAt;
  int id;

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        createdAt: json['createdAt'],
        code: json['code'],
        stateName: StateName.fromJson(json['state']),
        type: json['type'],
        countryId: json['countryId'],
        updatedAt: json['updatedAt'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'createdAt': createdAt,
        'code': code,
        'state': stateName.toJson(),
        'type': type,
        'countryId': countryId,
        'updatedAt': updatedAt,
        'id': id,
      };
}

class StateName {
  StateName({
    required this.en,
    required this.ta,
  });

  String en;
  String ta;

  factory StateName.fromJson(Map<String, dynamic> json) => StateName(
        en: json['en'],
        ta: json['ta'],
      );

  Map<String, dynamic> toJson() => {
        'en': en,
        'ta': ta,
      };
}
