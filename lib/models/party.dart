// To parse this JSON data, do
//
//     final party = partyFromJson(jsonString);

import 'dart:convert';

List<Party> partyFromJson(String str) =>
    List<Party>.from(json.decode(str).map((x) => Party.fromJson(x)));

String partyToJson(List<Party> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Party {
  Party({
    required this.name,
    required this.short,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  Name name;
  Name short;
  String imageUrl;
  int createdAt;
  int updatedAt;
  int id;

  factory Party.fromJson(Map<String, dynamic> json) => Party(
        name: Name.fromJson(json['name']),
        short: Name.fromJson(json['short']),
        imageUrl: json['imageUrl'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'name': name.toJson(),
        'short': short.toJson(),
        'imageUrl': imageUrl,
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
