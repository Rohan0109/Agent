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
    required this.wardNo,
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

  int wardNo;
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
        wardNo: json['wardNo'],
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
        'wardNo': wardNo,
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
