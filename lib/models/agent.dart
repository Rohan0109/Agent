// To parse this JSON data, do
//
//     final agent = agentFromJson(jsonString);

import 'dart:convert';

List<Agent> agentFromJson(String str) =>
    List<Agent>.from(json.decode(str).map((x) => Agent.fromJson(x)));

String agentToJson(List<Agent> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Agent {
  Agent({
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.isAuthorized,
    required this.id,
    this.areaName,
    this.country,
    this.district,
    this.doorNumber,
    this.email,
    this.name,
    this.ntkId,
    this.pincode,
    this.state,
    this.streetName,
    this.subWard,
    this.taluk,
    this.ward,
  });

  String phone;
  int createdAt;
  int updatedAt;
  bool isActive;
  bool isAuthorized;
  int id;
  dynamic areaName;
  dynamic country;
  dynamic district;
  dynamic doorNumber;
  dynamic email;
  dynamic name;
  dynamic ntkId;
  dynamic pincode;
  dynamic state;
  dynamic streetName;
  dynamic subWard;
  dynamic taluk;
  dynamic ward;

  factory Agent.fromJson(Map<String, dynamic> json) => Agent(
        phone: json["phone"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        isActive: json["isActive"],
        isAuthorized: json["isAuthorized"],
        id: json["id"],
        areaName: json["areaName"],
        country: json["country"],
        district: json["district"],
        doorNumber: json["doorNumber"],
        email: json["email"],
        name: json["name"],
        ntkId: json["ntkId"],
        pincode: json["pincode"],
        state: json["state"],
        streetName: json["streetName"],
        subWard: json["subWard"],
        taluk: json["taluk"],
        ward: json["ward"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "isActive": isActive,
        "isAuthorized": isAuthorized,
        "id": id,
        "areaName": areaName,
        "country": country,
        "district": district,
        "doorNumber": doorNumber,
        "email": email,
        "name": name,
        "ntkId": ntkId,
        "pincode": pincode,
        "state": state,
        "streetName": streetName,
        "subWard": subWard,
        "taluk": taluk,
        "ward": ward,
      };
}
