// To parse this JSON data, do
//
//     final vietNamMapModel = vietNamMapModelFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';

MapModelAsset vietNamMapModelFromJson(String str) =>
    MapModelAsset.fromJson(json.decode(str));

String vietNamMapModelToJson(MapModelAsset data) => json.encode(data.toJson());

class MapModelAsset {
  MapModelAsset({
    required this.type,
    required this.features,
  });

  String type;
  List<Feature> features;

  factory MapModelAsset.fromJson(Map<String, dynamic> json) => MapModelAsset(
        type: json["type"],
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
      };
}

class Feature {
  Feature({
    required this.type,
    required this.geometry,
    required this.properties,
  });

  FeatureType type;
  Geometry geometry;
  Properties properties;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        type: featureTypeValues.map[json["type"]]!,
        geometry: Geometry.fromJson(json["geometry"]),
        properties: Properties.fromJson(json["properties"]),
      );

  Map<String, dynamic> toJson() => {
        "type": featureTypeValues.reverse[type],
        "geometry": geometry.toJson(),
        "properties": properties.toJson(),
      };
}

class Geometry {
  Geometry({
    required this.type,
    required this.coordinates,
  });

  GeometryType type;
  List<List<List<dynamic>>> coordinates;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: geometryTypeValues.map[json["type"]]!,
        coordinates: List<List<List<dynamic>>>.from(json["coordinates"].map(
            (x) => List<List<dynamic>>.from(
                x.map((x) => List<dynamic>.from(x.map((x) => x)))))),
      );

  Map<String, dynamic> toJson() => {
        "type": geometryTypeValues.reverse[type],
        "coordinates": List<dynamic>.from(coordinates.map((x) =>
            List<dynamic>.from(
                x.map((x) => List<dynamic>.from(x.map((x) => x)))))),
      };
}

enum GeometryType { POLYGON, MULTI_POLYGON }

final geometryTypeValues = EnumValues({
  "MultiPolygon": GeometryType.MULTI_POLYGON,
  "Polygon": GeometryType.POLYGON
});

class Properties {
  Properties({
    required this.gid0,
    required this.name0,
    required this.gid1,
    required this.name1,
    required this.varname1,
    required this.nlName1,
    required this.type1,
    required this.engtype1,
    required this.cc1,
    required this.hasc1,
  });

  Gid0 gid0;
  Name0 name0;
  String gid1;
  String name1;
  String varname1;
  String nlName1;
  Type1 type1;
  Engtype1 engtype1;
  String cc1;
  String hasc1;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        gid0: gid0Values.map[json["GID_0"]] ?? Gid0.VNM,
        name0: name0Values.map[json["NAME_0"]] ?? Name0.VIETNAM,
        gid1: json["GID_1"] ?? "",
        name1: json["NAME_1"] ?? "",
        varname1: json["VARNAME_1"] ?? "",
        nlName1: json["NL_NAME_1"] ?? "",
        type1: type1Values.map[json["TYPE_1"]] ?? Type1.THNH_PH,
        engtype1: engtype1Values.map[json["ENGTYPE_1"]] ?? Engtype1.PROVINCE,
        cc1: json["CC_1"] ?? "",
        hasc1: json["HASC_1"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "GID_0": gid0Values.reverse[gid0],
        "NAME_0": name0Values.reverse[name0],
        "GID_1": gid1,
        "NAME_1": name1,
        "VARNAME_1": varname1,
        "NL_NAME_1": nlName1,
        "TYPE_1": type1Values.reverse[type1],
        "ENGTYPE_1": engtype1Values.reverse[engtype1],
        "CC_1": cc1,
        "HASC_1": hasc1,
      };
}

enum Engtype1 { PROVINCE, CITY }

final engtype1Values =
    EnumValues({"City": Engtype1.CITY, "Province": Engtype1.PROVINCE});

enum Gid0 { VNM }

final gid0Values = EnumValues({"VNM": Gid0.VNM});

enum Name0 { VIETNAM }

final name0Values = EnumValues({"Vietnam": Name0.VIETNAM});

enum Type1 { TNH, THNH_PH }

final type1Values = EnumValues({"Thành phố": Type1.THNH_PH, "Tỉnh": Type1.TNH});

enum FeatureType { FEATURE }

final featureTypeValues = EnumValues({"Feature": FeatureType.FEATURE});

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    // if (reverseMap == null) {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    // }
    return reverseMap;
  }
}

/// Collection of Australia state code data.
class MapModelView {
  /// Initialize the instance of the [Model] class.
  MapModelView({required this.title, required this.color, required this.total});

  /// Represents the Australia state name.
  final String title;

  /// Represents the Australia state color.
  Color color;

  /// Represents the Australia state code.
  int total;
}
