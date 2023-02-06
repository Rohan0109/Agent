// To parse this JSON data, do
//
//     final activity = activityFromJson(jsonString);

import 'dart:convert';

import 'package:Mugavan/models/party.dart';

List<Activity> activityFromJson(String str) =>
    List<Activity>.from(json.decode(str).map((x) => Activity.fromJson(x)));

String activityToJson(List<Activity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Activity {
  Activity({
    required this.agentId,
    required this.voterId,
    required this.partyId,
    required this.createdAt,
    required this.updatedAt,
    required this.percentage,
    required this.command,
    required this.id,
  });

  int agentId;
  int voterId;
  List<Party> partyId;
  int createdAt;
  int updatedAt;
  String percentage;
  String command;
  int id;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        agentId: json['agentId'],
        voterId: json['voterId'],
        partyId:
            List<Party>.from(json['partyId'].map((x) => Party.fromJson(x))),
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        percentage: json['percentage'],
        command: json['command'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'agentId': agentId,
        'voterId': voterId,
        'partyId': List<dynamic>.from(partyId.map((x) => x.toJson())),
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'percentage': percentage,
        'command': command,
        'id': id,
      };
}
