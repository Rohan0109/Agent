// To parse this JSON data, do
//
//     final parliament = parliamentFromJson(jsonString);

import 'dart:convert';

List<Parliament> parliamentFromJson(String str) =>
    List<Parliament>.from(json.decode(str).map((x) => Parliament.fromJson(x)));

String parliamentToJson(List<Parliament> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Parliament {
  Parliament({
    required this.parliamentNo,
    required this.parliamentName,
    required this.typeOfParliament,
    required this.districtId,
    required this.stateId,
    required this.countryId,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  int parliamentNo;
  ParliamentName parliamentName;
  String typeOfParliament;
  int districtId;
  int stateId;
  int countryId;
  int createdAt;
  int updatedAt;
  int id;

  factory Parliament.fromJson(Map<String, dynamic> json) => Parliament(
        parliamentNo: json['parliamentNo'],
        parliamentName: ParliamentName.fromJson(json['parliamentName']),
        typeOfParliament: json['typeOfParliament'],
        districtId: json['districtId'],
        stateId: json['stateId'],
        countryId: json['countryId'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'parliamentNo': parliamentNo,
        'parliamentName': parliamentName.toJson(),
        'typeOfParliament': typeOfParliament,
        'districtId': districtId,
        'stateId': stateId,
        'countryId': countryId,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'id': id,
      };
}

class ParliamentName {
  ParliamentName({
    required this.en,
    required this.ta,
  });

  String en;
  String ta;

  factory ParliamentName.fromJson(Map<String, dynamic> json) => ParliamentName(
        en: json['en'],
        ta: json['ta'],
      );

  Map<String, dynamic> toJson() => {
        'en': en,
        'ta': ta,
      };
}
