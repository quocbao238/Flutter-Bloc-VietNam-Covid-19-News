// To parse this JSON data, do
//
//     final provinceMapModel = provinceMapModelFromJson(jsonString);

import 'dart:convert';

ProvinceMapModel provinceMapModelFromJson(String str) =>
    ProvinceMapModel.fromJson(json.decode(str));

String provinceMapModelToJson(ProvinceMapModel data) =>
    json.encode(data.toJson());

class ProvinceMapModel {
  ProvinceMapModel({
    required this.list,
  });

  List<ProvinceMap> list;

  factory ProvinceMapModel.fromJson(Map<String, dynamic> json) =>
      ProvinceMapModel(
        list: List<ProvinceMap>.from(
            json["list"].map((x) => ProvinceMap.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class ProvinceMap {
  ProvinceMap({
    this.name,
    this.color,
    this.data,
    this.patientProvinceModel,
  });

  String? name;
  String? color;
  List<Datum>? data;
  String? patientProvinceModel;

  factory ProvinceMap.fromJson(Map<String, dynamic> json) => ProvinceMap(
        name: json["name"],
        color: json["color"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        patientProvinceModel: json["PatientProvinceModel"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "color": color,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "PatientProvinceModel": patientProvinceModel ?? ""
      };
}

class Datum {
  Datum({
    required this.id,
    required this.title,
    required this.clsconfirmed,
    required this.clsdeaths,
    required this.clslevel,
    required this.level,
    required this.confirmed,
    required this.incconfirmed,
    required this.recovered,
    required this.deaths,
    required this.incdeath,
    required this.onevaccine,
    required this.donevaccine,
    required this.onevaccinepercent,
    required this.donevaccinepercent,
  });

  String? id;
  String? title;
  String? clsconfirmed;
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
  int? onevaccinepercent;
  int? donevaccinepercent;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"] ?? "",
        clsconfirmed: json["clsconfirmed"],
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
        onevaccinepercent: json["onevaccinepercent"].toInt(),
        donevaccinepercent: json["donevaccinepercent"].toInt(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title ?? "",
        "clsconfirmed": clsconfirmed,
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

enum Clslevel { RED_ZONE }

final clslevelValues = EnumValues({"red-zone": Clslevel.RED_ZONE});

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
