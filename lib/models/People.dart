// To parse this JSON data, do
//
//     final people = peopleFromJson(jsonString);

import 'dart:convert';

List<People> peopleFromJson(String str) =>
    List<People>.from(json.decode(str).map((x) => People.fromJson(x)));

String peopleToJson(List<People> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class People {
  People({
    this.district,
    this.country,
    this.state,
    this.ward,
    this.subWard,
    this.email,
    this.phone,
    this.name,
    this.taluk,
    this.doorNumber,
    this.streetName,
    this.areaName,
    this.pincode,
    this.voterId,
    this.fatherName,
    this.isTaken,
    this.isActive,
    this.isAuthorized,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  dynamic district;
  dynamic country;
  dynamic state;
  dynamic ward;
  dynamic subWard;
  dynamic email;
  dynamic phone;
  dynamic name;
  dynamic taluk;
  dynamic doorNumber;
  dynamic streetName;
  dynamic areaName;
  dynamic pincode;
  dynamic voterId;
  dynamic fatherName;
  dynamic isTaken;
  dynamic isActive;
  dynamic isAuthorized;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic id;

  factory People.fromJson(Map<String, dynamic> json) => People(
        district: json["district"],
        country: json["country"],
        state: json["state"],
        ward: json["ward"],
        subWard: json["subWard"],
        email: json["email"],
        phone: json["phone"],
        name: json["name"],
        taluk: json["taluk"],
        doorNumber: json["doorNumber"],
        streetName: json["streetName"],
        areaName: json["areaName"],
        pincode: json["pincode"],
        voterId: json["voterId"],
        fatherName: json["fatherName"],
        isTaken: json["isTaken"],
        isActive: json["isActive"],
        isAuthorized: json["isAuthorized"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "district": district,
        "country": country,
        "state": state,
        "ward": ward,
        "subWard": subWard,
        "email": email,
        "phone": phone,
        "name": name,
        "taluk": taluk,
        "doorNumber": doorNumber,
        "streetName": streetName,
        "areaName": areaName,
        "pincode": pincode,
        "voterId": voterId,
        "fatherName": fatherName,
        "isTaken": isTaken,
        "isActive": isActive,
        "isAuthorized": isAuthorized,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "id": id,
      };
}
