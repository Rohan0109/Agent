// To parse this JSON data, do
//
//     final troop = troopFromJson(jsonString);

import 'dart:convert';

List<Troop> troopFromJson(String str) =>
    List<Troop>.from(json.decode(str).map((x) => Troop.fromJson(x)));

String troopToJson(List<Troop> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Troop {
  Troop({
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
    required this.activity,
    required this.report,
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
  Activity activity;
  Report report;

  factory Troop.fromJson(Map<String, dynamic> json) => Troop(
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
        activity: Activity.fromJson(json["activity"]),
        report: Report.fromJson(json["report"]),
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
        "activity": activity.toJson(),
        "report": report.toJson(),
      };
}

class Activity {
  Activity({
    this.statusPercentage,
    this.status,
  });

  dynamic statusPercentage;
  dynamic status;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        statusPercentage: json["statusPercentage"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "statusPercentage": statusPercentage,
        "status": status,
      };
}

class Report {
  Report({
    this.assignedDate,
    this.agentId,
  });

  dynamic assignedDate;
  dynamic agentId;

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        assignedDate: json["assignedDate"],
        agentId: json["agentId"],
      );

  Map<String, dynamic> toJson() => {
        "assignedDate": assignedDate,
        "agentId": agentId,
      };
}
