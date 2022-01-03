import 'dart:convert';

SummPatient summPatientFromJson(String str) =>
    SummPatient.fromJson(json.decode(str));

String summPatientToJson(SummPatient data) => json.encode(data.toJson());

class SummPatient {
  SummPatient({
    required this.success,
    required this.data,
  });

  bool success;
  Data data;

  factory SummPatient.fromJson(Map<String, dynamic> json) => SummPatient(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.issueDate,
    required this.confirmed,
    required this.recovered,
    required this.death,
    required this.createdDate,
    required this.modifiedDate,
    required this.plusConfirmed,
    required this.plusRecovered,
    required this.plusDeath,
  });

  int id;
  DateTime issueDate;
  int confirmed;
  int recovered;
  int death;
  DateTime createdDate;
  dynamic modifiedDate;
  int plusConfirmed;
  int plusRecovered;
  int plusDeath;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["Id"],
        issueDate: DateTime.parse(json["IssueDate"]),
        confirmed: json["Confirmed"],
        recovered: json["Recovered"],
        death: json["Death"],
        createdDate: DateTime.parse(json["CreatedDate"]),
        modifiedDate: json["ModifiedDate"],
        plusConfirmed: json["PlusConfirmed"],
        plusRecovered: json["PlusRecovered"],
        plusDeath: json["PlusDeath"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "IssueDate": issueDate.toIso8601String(),
        "Confirmed": confirmed,
        "Recovered": recovered,
        "Death": death,
        "CreatedDate": createdDate.toIso8601String(),
        "ModifiedDate": modifiedDate,
        "PlusConfirmed": plusConfirmed,
        "PlusRecovered": plusRecovered,
        "PlusDeath": plusDeath,
      };
}
