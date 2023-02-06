// To parse this JSON data, do
//
//     final localbody = localbodyFromJson(jsonString);

import 'dart:convert';

List<Localbody> localbodyFromJson(String str) =>
    List<Localbody>.from(json.decode(str).map((x) => Localbody.fromJson(x)));

String localbodyToJson(List<Localbody> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Localbody {
  Localbody({
    required this.localbody,
    required this.type,
    required this.category,
    required this.assemblyId,
    required this.parliamentId,
    required this.districtId,
    required this.stateId,
    required this.countryId,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.code,
  });

  LocalbodyClass localbody;
  String type;
  String category;
  int assemblyId;
  int parliamentId;
  int districtId;
  int stateId;
  int countryId;
  int createdAt;
  int updatedAt;
  int id;
  int code;

  factory Localbody.fromJson(Map<String, dynamic> json) => Localbody(
        localbody: LocalbodyClass.fromJson(json['localbody']),
        type: json['type'],
        category: json['category'],
        assemblyId: json['assemblyId'],
        parliamentId: json['parliamentId'],
        districtId: json['districtId'],
        stateId: json['stateId'],
        countryId: json['countryId'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        id: json['id'],
        code: json['code'],
      );

  Map<String, dynamic> toJson() => {
        'localbody': localbody.toJson(),
        'type': type,
        'category': category,
        'assemblyId': assemblyId,
        'parliamentId': parliamentId,
        'districtId': districtId,
        'stateId': stateId,
        'countryId': countryId,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'id': id,
        'code': code,
      };
}

class LocalbodyClass {
  LocalbodyClass({
    required this.en,
    required this.ta,
  });

  String en;
  String ta;

  factory LocalbodyClass.fromJson(Map<String, dynamic> json) => LocalbodyClass(
        en: json['en'],
        ta: json['ta'],
      );

  Map<String, dynamic> toJson() => {
        'en': en,
        'ta': ta,
      };
}
