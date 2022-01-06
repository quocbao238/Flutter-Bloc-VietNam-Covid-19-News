// To parse this JSON data, do
//
//     final provinceModel = provinceModelFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

ProvinceModel provinceModelFromJson(String str) =>
    ProvinceModel.fromJson(json.decode(str));

String provinceModelToJson(ProvinceModel data) => json.encode(data.toJson());

class ProvinceModel {
  ProvinceModel({
    required this.success,
    required this.list,
  });

  bool success;
  List<Province> list;

  factory ProvinceModel.fromJson(Map<String, dynamic> json) => ProvinceModel(
        success: json["success"],
        list:
            List<Province>.from(json["list"].map((x) => Province.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class Province {
  Province({
    this.id,
    this.title,
    this.clsconfirmed,
    this.clsdeaths,
    this.clslevel,
    this.level,
    this.confirmed,
    this.incconfirmed,
    this.recovered,
    this.deaths,
    this.incdeath,
    this.onevaccine,
    this.donevaccine,
    this.onevaccinepercent,
    this.donevaccinepercent,
  });

  String? id;
  String? title;
  Clsconfirmed? clsconfirmed;
  String? clsdeaths;
  Clslevel? clslevel;
  int? level;
  int? confirmed;
  int? incconfirmed;
  int? recovered;
  int? deaths;
  int? incdeath;
  int? onevaccine;
  int? donevaccine;
  double? onevaccinepercent;
  double? donevaccinepercent;

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        id: json["id"],
        title: json["title"],
        clsconfirmed: clsconfirmedValues.map[json["clsconfirmed"]],
        clsdeaths: json["clsdeaths"],
        clslevel: clslevelValues.map[json["clslevel"]]!,
        level: json["level"],
        confirmed: json["confirmed"],
        incconfirmed: json["incconfirmed"],
        recovered: json["recovered"],
        deaths: json["deaths"],
        incdeath: json["incdeath"],
        onevaccine: json["onevaccine"],
        donevaccine: json["donevaccine"],
        onevaccinepercent: json["onevaccinepercent"].toDouble(),
        donevaccinepercent: json["donevaccinepercent"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "clsconfirmed": clsconfirmedValues.reverse[clsconfirmed],
        "clsdeaths": clsdeaths,
        "clslevel": clslevelValues.reverse[clslevel],
        "level": level,
        "confirmed": confirmed,
        "incconfirmed": incconfirmed,
        "recovered": recovered,
        "deaths": deaths,
        "incdeath": incdeath,
        "onevaccine": onevaccine,
        "donevaccine": donevaccine,
        "onevaccinepercent": onevaccinepercent,
        "donevaccinepercent": donevaccinepercent,
      };
}

enum Clsconfirmed { INC }

final clsconfirmedValues = EnumValues({"inc": Clsconfirmed.INC});

enum Clslevel { GREEN_ZONE, YELLOW_ZONE, ORANGE_ZONE }

final clslevelValues = EnumValues({
  "green-zone": Clslevel.GREEN_ZONE,
  "orange-zone": Clslevel.ORANGE_ZONE,
  "yellow-zone": Clslevel.YELLOW_ZONE
});

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));

    return reverseMap;
  }
}
