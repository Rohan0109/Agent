// To parse this JSON data, do
//
//     final voter = voterFromJson(jsonString);

import 'dart:convert';

List<Voter> voterFromJson(String str) =>
    List<Voter>.from(json.decode(str).map((x) => Voter.fromJson(x)));

String voterToJson(List<Voter> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Voter {
  Voter({
    required this.voterId,
    required this.name,
    this.sentinal,
    this.doorNo,
    this.age,
    this.sex,
    this.isFather,
    this.boothId,
    this.sno,
    required this.wardId,
    required this.talukId,
    required this.localbodyId,
    required this.assemblyId,
    required this.parliamentId,
    required this.districtId,
    required this.stateId,
    required this.countryId,
    required this.createdAt,
    required this.updatedAt,
    this.isAgent,
    this.isTaken,
    required this.id,
    this.agentId,
    this.memberId,
    this.phone,
  });

  String voterId;
  Name name;
  Name? sentinal;
  String? doorNo;
  int? age;
  String? sex;
  bool? isFather;
  int? boothId;
  int wardId;
  int talukId;
  int localbodyId;
  int assemblyId;
  int parliamentId;
  int districtId;
  int stateId;
  int countryId;
  int createdAt;
  int updatedAt;
  bool? isAgent;
  bool? isTaken;
  int id;
  int? agentId;
  String? memberId;
  String? phone;
  int? sno;

  factory Voter.fromJson(Map<String, dynamic> json) => Voter(
        voterId: json['voterId'],
        name: Name.fromJson(json['name']),
        sentinal:
            json['sentinal'] != null ? Name.fromJson(json['sentinal']) : null,
        doorNo: json['doorNo'],
        age: json['age'],
        sex: json['sex'],
        isFather: json['isFather'],
        boothId: json['boothId'],
        wardId: json['wardId'],
        talukId: json['talukId'],
        localbodyId: json['localbodyId'],
        assemblyId: json['assemblyId'],
        parliamentId: json['parliamentId'],
        districtId: json['districtId'],
        stateId: json['stateId'],
        countryId: json['countryId'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        isAgent: json['isAgent'],
        isTaken: json['isTaken'],
        id: json['id'],
        agentId: json['agentId'],
        memberId: json['memberId'],
        phone: json['phone'],
        sno: json['sno'],
      );

  Map<String, dynamic> toJson() => {
        'voterId': voterId,
        'name': name.toJson(),
        'sentinal': sentinal?.toJson(),
        'doorNo': doorNo,
        'age': age,
        'sex': sex,
        'isFather': isFather,
        'boothId': boothId,
        'wardId': wardId,
        'talukId': talukId,
        'localbodyId': localbodyId,
        'assemblyId': assemblyId,
        'parliamentId': parliamentId,
        'districtId': districtId,
        'stateId': stateId,
        'countryId': countryId,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'isAgent': isAgent,
        'isTaken': isTaken,
        'id': id,
        'agentId': agentId,
        'memberId': memberId,
        'phone': phone,
        'sno': sno
      };
}

class Name {
  Name({
    required this.en,
    required this.ta,
  });

  String en;
  String ta;

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        en: json['en'],
        ta: json['ta'],
      );

  Map<String, dynamic> toJson() => {
        'en': en,
        'ta': ta,
      };
}
