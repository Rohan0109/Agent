// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

List<Message> messageFromJson(String str) =>
    List<Message>.from(json.decode(str).map((x) => Message.fromJson(x)));

String messageToJson(List<Message> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Message {
  Message({
    required this.message,
    required this.agentId,
    required this.voterId,
    required this.createdAt,
    required this.updatedAt,
  });

  String message;
  int agentId;
  int voterId;
  int createdAt;
  int updatedAt;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        message: json['message'],
        agentId: json['agentId'],
        voterId: json['voterId'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'agentId': agentId,
        'voterId': voterId,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
