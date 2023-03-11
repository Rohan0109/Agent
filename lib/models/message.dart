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
    required this.voterId,
    required this.createdAt,
    required this.updatedAt,
    required this.agentId,
    required this.sender,
    required this.receiver,
    required this.id,
  });

  String message;
  int voterId;
  int createdAt;
  int updatedAt;
  int agentId;
  String sender;
  String receiver;
  int id;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        message: json['message'],
        voterId: json['voterId'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        agentId: json['agentId'],
        sender: json['sender'],
        receiver: json['receiver'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'voterId': voterId,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'agentId': agentId,
        'sender': sender,
        'receiver': receiver,
        'id': id,
      };
}
