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
    required this.district,
    required this.country,
    required this.state,
    required this.ward,
    required this.subWard,
    required this.phoneNumber,
    required this.isActive,
    required this.isAuthorized,
    required this.createAt,
    required this.isTaken,
    required this.id,
    required this.name,
    required this.taluk,
    required this.report,
  });

  String district;
  String country;
  String state;
  String ward;
  String subWard;
  String phoneNumber;
  bool isActive;
  bool isAuthorized;
  DateTime createAt;
  bool isTaken;
  int id;
  String name;
  String taluk;
  Report report;

  factory People.fromJson(Map<String, dynamic> json) => People(
        district: json["district"],
        country: json["country"],
        state: json["state"],
        ward: json["ward"],
        subWard: json["subWard"],
        phoneNumber: json["phoneNumber"],
        isActive: json["isActive"],
        isAuthorized: json["isAuthorized"],
        createAt: DateTime.parse(json["createAt"]),
        isTaken: json["isTaken"],
        id: json["id"],
        name: json["name"],
        taluk: json["taluk"],
        report: Report.fromJson(json["report"]),
      );

  Map<String, dynamic> toJson() => {
        "district": district,
        "country": country,
        "state": state,
        "ward": ward,
        "subWard": subWard,
        "phoneNumber": phoneNumber,
        "isActive": isActive,
        "isAuthorized": isAuthorized,
        "createAt":
            "${createAt.year.toString().padLeft(4, '0')}-${createAt.month.toString().padLeft(2, '0')}-${createAt.day.toString().padLeft(2, '0')}",
        "isTaken": isTaken,
        "id": id,
        "name": name,
        "taluk": taluk,
        "report": report.toJson(),
      };
}

class Report {
  Report({
    required this.assignedDate,
    required this.agentId,
  });

  DateTime assignedDate;
  int agentId;

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        assignedDate: DateTime.parse(json["assignedDate"]),
        agentId: json["agentId"],
      );

  Map<String, dynamic> toJson() => {
        "assignedDate":
            "${assignedDate.year.toString().padLeft(4, '0')}-${assignedDate.month.toString().padLeft(2, '0')}-${assignedDate.day.toString().padLeft(2, '0')}",
        "agentId": agentId,
      };
}
