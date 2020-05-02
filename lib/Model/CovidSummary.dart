// To parse this JSON data, do
//
//     final covidSummary = covidSummaryFromJson(jsonString);

import 'dart:convert';

CovidSummary covidSummaryFromJson(String str) => CovidSummary.fromJson(json.decode(str));

String covidSummaryToJson(CovidSummary data) => json.encode(data.toJson());

class CovidSummary {
  Confirmed confirmed;
  Confirmed recovered;
  Confirmed deaths;
  DateTime lastUpdate;

  CovidSummary({
    this.confirmed,
    this.recovered,
    this.deaths,
    this.lastUpdate,
  });

  factory CovidSummary.fromJson(Map<String, dynamic> json) => CovidSummary(
    confirmed: Confirmed.fromJson(json["confirmed"]),
    recovered: Confirmed.fromJson(json["recovered"]),
    deaths: Confirmed.fromJson(json["deaths"]),
    lastUpdate: DateTime.parse(json["lastUpdate"]),
  );

  Map<String, dynamic> toJson() => {
    "confirmed": confirmed.toJson(),
    "recovered": recovered.toJson(),
    "deaths": deaths.toJson(),
    "lastUpdate": lastUpdate.toIso8601String(),
  };
}

class Confirmed {
  int value;
  String detail;

  Confirmed({
    this.value,
    this.detail,
  });

  factory Confirmed.fromJson(Map<String, dynamic> json) => Confirmed(
    value: json["value"],
    detail: json["detail"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "detail": detail,
  };
}
