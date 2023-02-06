// To parse this JSON data, do
//
//     final country = countryFromJson(jsonString);

import 'dart:convert';

List<Country> countryFromJson(String str) =>
    List<Country>.from(json.decode(str).map((x) => Country.fromJson(x)));

String countryToJson(List<Country> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Country {
  Country({
    required this.country,
    required this.createdAt,
    required this.code,
    required this.updatedAt,
    required this.id,
  });

  CountryClass country;
  int createdAt;
  String code;
  int updatedAt;
  int id;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        country: CountryClass.fromJson(json['country']),
        createdAt: json['createdAt'],
        code: json['code'],
        updatedAt: json['updatedAt'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'country': country.toJson(),
        'createdAt': createdAt,
        'code': code,
        'updatedAt': updatedAt,
        'id': id,
      };
}

class CountryClass {
  CountryClass({
    required this.en,
    required this.ta,
  });

  String en;
  String ta;

  factory CountryClass.fromJson(Map<String, dynamic> json) => CountryClass(
        en: json['en'],
        ta: json['ta'],
      );

  Map<String, dynamic> toJson() => {
        'en': en,
        'ta': ta,
      };
}
