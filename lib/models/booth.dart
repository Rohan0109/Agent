// To parse this JSON data, do
//
//     final booth = boothFromJson(jsonString);

import 'dart:convert';

List<Booth> boothFromJson(String str) =>
    List<Booth>.from(json.decode(str).map((x) => Booth.fromJson(x)));

String boothToJson(List<Booth> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Booth {
  Booth({
    required this.name,
    required this.boothNo,
    required this.type,
    required this.address,
    required this.noOfVoters,
    required this.startingNo,
    required this.endingNo,
    required this.men,
    required this.women,
    required this.transgenders,
    required this.wardId,
    required this.localbodyId,
    required this.talukId,
    required this.assemblyId,
    required this.parliamentId,
    required this.districtId,
    required this.stateId,
    required this.countryId,
    required this.createdAt,
    required this.updatedAt,
    required this.code,
    required this.id,
  });

  Name name;
  int boothNo;
  String type;
  String address;
  int noOfVoters;
  int startingNo;
  int endingNo;
  int men;
  int women;
  int transgenders;
  int wardId;
  int localbodyId;
  int talukId;
  int assemblyId;
  int parliamentId;
  int districtId;
  int stateId;
  int countryId;
  int createdAt;
  int updatedAt;
  String code;
  int id;

  factory Booth.fromJson(Map<String, dynamic> json) => Booth(
        name: Name.fromJson(json['name']),
        boothNo: json['boothNo'],
        type: json['type'],
        address: json['address'],
        noOfVoters: json['noOfVoters'],
        startingNo: json['startingNo'],
        endingNo: json['endingNo'],
        men: json['men'],
        women: json['women'],
        transgenders: json['transgenders'],
        wardId: json['wardId'],
        localbodyId: json['localbodyId'],
        talukId: json['talukId'],
        assemblyId: json['assemblyId'],
        parliamentId: json['parliamentId'],
        districtId: json['districtId'],
        stateId: json['stateId'],
        countryId: json['countryId'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        code: json['code'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'name': name.toJson(),
        'boothNo': boothNo,
        'type': type,
        'address': address,
        'noOfVoters': noOfVoters,
        'startingNo': startingNo,
        'endingNo': endingNo,
        'men': men,
        'women': women,
        'transgenders': transgenders,
        'wardId': wardId,
        'localbodyId': localbodyId,
        'talukId': talukId,
        'assemblyId': assemblyId,
        'parliamentId': parliamentId,
        'districtId': districtId,
        'stateId': stateId,
        'countryId': countryId,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'code': code,
        'id': id,
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
