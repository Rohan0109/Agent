// To parse this JSON data, do
//
//     final district = districtFromJson(jsonString);

import 'dart:convert';

List<District> districtFromJson(String str) =>
    List<District>.from(json.decode(str).map((x) => District.fromJson(x)));

String districtToJson(List<District> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class District {
  District({
    required this.createdAt,
    required this.code,
    required this.district,
    required this.stateId,
    required this.countryId,
    required this.updatedAt,
    required this.id,
  });

  int createdAt;
  int code;
  DistrictClass district;
  int stateId;
  int countryId;
  int updatedAt;
  int id;

  factory District.fromJson(Map<String, dynamic> json) => District(
        createdAt: json['createdAt'],
        code: json['code'],
        district: DistrictClass.fromJson(json['district']),
        stateId: json['stateId'],
        countryId: json['countryId'],
        updatedAt: json['updatedAt'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'createdAt': createdAt,
        'code': code,
        'district': district.toJson(),
        'stateId': stateId,
        'countryId': countryId,
        'updatedAt': updatedAt,
        'id': id,
      };
}

class DistrictClass {
  DistrictClass({
    required this.en,
    required this.ta,
  });

  String en;
  String ta;

  factory DistrictClass.fromJson(Map<String, dynamic> json) => DistrictClass(
        en: json['en'],
        ta: json['ta'],
      );

  Map<String, dynamic> toJson() => {
        'en': en,
        'ta': ta,
      };
}
