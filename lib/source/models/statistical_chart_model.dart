// To parse this JSON data, do
//
//     final statisticalChart = statisticalChartFromJson(jsonString);

import 'dart:convert';

StatisticalChart statisticalChartFromJson(String str) =>
    StatisticalChart.fromJson(json.decode(str));

String statisticalChartToJson(StatisticalChart data) =>
    json.encode(data.toJson());

class StatisticalChart {
  StatisticalChart({
    required this.success,
    required this.list,
  });

  bool success;
  List<StatisticalChartItem> list;

  factory StatisticalChart.fromJson(Map<String, dynamic> json) =>
      StatisticalChart(
        success: json["success"],
        list: List<StatisticalChartItem>.from(
            json["list"].map((x) => StatisticalChartItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class StatisticalChartItem {
  StatisticalChartItem({
    required this.issueDate,
    required this.date,
    required this.confirmed,
    required this.recovered,
    required this.death,
  });

  DateTime issueDate;
  String date;
  int confirmed;
  int recovered;
  int death;

  factory StatisticalChartItem.fromJson(Map<String, dynamic> json) =>
      StatisticalChartItem(
        issueDate: DateTime.parse(json["IssueDate"]),
        date: json["date"],
        confirmed: json["confirmed"] ?? 0,
        recovered: json["recovered"] ?? 0,
        death: json["death"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "IssueDate": issueDate.toIso8601String(),
        "date": date,
        "confirmed": confirmed,
        "recovered": recovered,
        "death": death,
      };
}
