// To parse this JSON data, do
//
//     final taluk = talukFromJson(jsonString);

import 'dart:convert';

List<Taluk> talukFromJson(String str) =>
    List<Taluk>.from(json.decode(str).map((x) => Taluk.fromJson(x)));

String talukToJson(List<Taluk> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Taluk {
  Taluk({
    required this.taluk,
    required this.assemblyId,
    required this.parliamentId,
    required this.districtId,
    required this.stateId,
    required this.country,
    required this.createdAt,
    required this.updatedAt,
    required this.code,
    required this.id,
  });

  TalukClass taluk;
  int assemblyId;
  int parliamentId;
  int districtId;
  int stateId;
  int country;
  int createdAt;
  int updatedAt;
  int code;
  int id;

  factory Taluk.fromJson(Map<String, dynamic> json) => Taluk(
        taluk: TalukClass.fromJson(json['taluk']),
        assemblyId: json['assemblyId'],
        parliamentId: json['parliamentId'],
        districtId: json['districtId'],
        stateId: json['stateId'],
        country: json['country'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        code: json['code'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'taluk': taluk.toJson(),
        'assemblyId': assemblyId,
        'parliamentId': parliamentId,
        'districtId': districtId,
        'stateId': stateId,
        'country': country,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'code': code,
        'id': id,
      };
}

class TalukClass {
  TalukClass({
    required this.en,
    required this.ta,
  });

  String en;
  String ta;

  factory TalukClass.fromJson(Map<String, dynamic> json) => TalukClass(
        en: json['en'],
        ta: json['ta'],
      );

  Map<String, dynamic> toJson() => {
        'en': en,
        'ta': ta,
      };
}
