// To parse this JSON data, do
//
//     final chartModel = chartModelFromJson(jsonString);

import 'dart:convert';

List<ChartModel> chartModelFromJson(String str) =>
    List<ChartModel>.from(json.decode(str).map((x) => ChartModel.fromJson(x)));

String chartModelToJson(List<ChartModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChartModel {
  ChartModel({
    required this.countryId,
    required this.stateId,
    required this.districtId,
    required this.parliamentId,
    required this.assemblyId,
    required this.talukId,
    required this.localbodyId,
    required this.wardId,
    required this.voterId,
    required this.partyId,
    required this.percentage,
    required this.createdAt,
    required this.updatedAt,
    required this.agentId,
    required this.id,
    this.command,
  });

  int countryId;
  int stateId;
  int districtId;
  int parliamentId;
  int assemblyId;
  int talukId;
  int localbodyId;
  int wardId;
  int voterId;
  List<PartyId> partyId;
  String percentage;
  int createdAt;
  int updatedAt;
  int agentId;
  int id;
  String? command;

  factory ChartModel.fromJson(Map<String, dynamic> json) => ChartModel(
        countryId: json['countryId'],
        stateId: json['stateId'],
        districtId: json['districtId'],
        parliamentId: json['parliamentId'],
        assemblyId: json['assemblyId'],
        talukId: json['talukId'],
        localbodyId: json['localbodyId'],
        wardId: json['wardId'],
        voterId: json['voterId'],
        partyId:
            List<PartyId>.from(json['partyId'].map((x) => PartyId.fromJson(x))),
        percentage: json['percentage'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        agentId: json['agentId'],
        id: json['id'],
        command: json['command'],
      );

  Map<String, dynamic> toJson() => {
        'countryId': countryId,
        'stateId': stateId,
        'districtId': districtId,
        'parliamentId': parliamentId,
        'assemblyId': assemblyId,
        'talukId': talukId,
        'localbodyId': localbodyId,
        'wardId': wardId,
        'voterId': voterId,
        'partyId': List<dynamic>.from(partyId.map((x) => x.toJson())),
        'percentage': percentage,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'agentId': agentId,
        'id': id,
        'command': command,
      };
}

class PartyId {
  PartyId({
    required this.name,
    required this.short,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  Name name;
  Name short;
  int createdAt;
  int updatedAt;
  int id;

  factory PartyId.fromJson(Map<String, dynamic> json) => PartyId(
        name: Name.fromJson(json['name']),
        short: Name.fromJson(json['short']),
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'name': name.toJson(),
        'short': short.toJson(),
        'createdAt': createdAt,
        'updatedAt': updatedAt,
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
