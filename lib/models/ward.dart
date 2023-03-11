// To parse this JSON data, do
//
//     final ward = wardFromJson(jsonString);

import 'dart:convert';

List<Ward> wardFromJson(String str) =>
    List<Ward>.from(json.decode(str).map((x) => Ward.fromJson(x)));

String wardToJson(List<Ward> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ward {
  Ward({
    required this.ward,
    required this.localbodyId,
    required this.talukId,
    required this.assemblyId,
    required this.parliamentId,
    required this.districtId,
    required this.stateId,
    required this.countryId,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  WardClass ward;
  int localbodyId;
  int talukId;
  int assemblyId;
  int parliamentId;
  int districtId;
  int stateId;
  int countryId;
  int createdAt;
  int updatedAt;
  int id;

  factory Ward.fromJson(Map<String, dynamic> json) => Ward(
        ward: WardClass.fromJson(json['ward']),
        localbodyId: json['localbodyId'],
        talukId: json['talukId'],
        assemblyId: json['assemblyId'],
        parliamentId: json['parliamentId'],
        districtId: json['districtId'],
        stateId: json['stateId'],
        countryId: json['countryId'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'wardNo': ward.toJson(),
        'localbodyId': localbodyId,
        'talukId': talukId,
        'assemblyId': assemblyId,
        'parliamentId': parliamentId,
        'districtId': districtId,
        'stateId': stateId,
        'countryId': countryId,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'id': id,
      };
}

class WardClass {
  WardClass({
    required this.en,
    required this.ta,
  });

  String en;
  String ta;

  factory WardClass.fromJson(Map<String, dynamic> json) => WardClass(
        en: json['en'],
        ta: json['ta'],
      );

  Map<String, dynamic> toJson() => {
        'en': en,
        'ta': ta,
      };
}
