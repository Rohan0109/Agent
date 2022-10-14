// To parse this JSON data, do
//
//     final display = displayFromJson(jsonString);

import 'dart:convert';

List<Display> displayFromJson(String str) =>
    List<Display>.from(json.decode(str).map((x) => Display.fromJson(x)));

String displayToJson(List<Display> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Display {
  Display({
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
    required this.activity,
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
  Activity activity;

  factory Display.fromJson(Map<String, dynamic> json) => Display(
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
        activity: Activity.fromJson(json["activity"]),
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
        "activity": activity.toJson(),
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

class Activity {
  Activity({
    required this.statusPercentage,
    required this.status,
  });

  String statusPercentage;
  String status;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        statusPercentage: json["statusPercentage"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "statusPercentage": statusPercentage,
        "status": status,
      };
}
