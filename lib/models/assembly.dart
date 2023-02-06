// To parse this JSON data, do
//
//     final assembly = assemblyFromJson(jsonString);

import 'dart:convert';

List<Assembly> assemblyFromJson(String str) =>
    List<Assembly>.from(json.decode(str).map((x) => Assembly.fromJson(x)));

String assemblyToJson(List<Assembly> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Assembly {
  Assembly({
    required this.assemblyNo,
    required this.assembly,
    required this.typeOfAssembly,
    required this.parliamentId,
    required this.districtId,
    required this.stateId,
    required this.countryId,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  int assemblyNo;
  AssemblyClass assembly;
  String typeOfAssembly;
  int parliamentId;
  int districtId;
  int stateId;
  int countryId;
  int createdAt;
  int updatedAt;
  int id;

  factory Assembly.fromJson(Map<String, dynamic> json) => Assembly(
        assemblyNo: json['assemblyNo'],
        assembly: AssemblyClass.fromJson(json['assembly']),
        typeOfAssembly: json['typeOfAssembly'],
        parliamentId: json['parliamentId'],
        districtId: json['districtId'],
        stateId: json['stateId'],
        countryId: json['countryId'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'assemblyNo': assemblyNo,
        'assembly': assembly.toJson(),
        'typeOfAssembly': typeOfAssembly,
        'parliamentId': parliamentId,
        'districtId': districtId,
        'stateId': stateId,
        'countryId': countryId,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'id': id,
      };
}

class AssemblyClass {
  AssemblyClass({
    required this.en,
    required this.ta,
  });

  String en;
  String ta;

  factory AssemblyClass.fromJson(Map<String, dynamic> json) => AssemblyClass(
        en: json['en'],
        ta: json['ta'],
      );

  Map<String, dynamic> toJson() => {
        'en': en,
        'ta': ta,
      };
}
