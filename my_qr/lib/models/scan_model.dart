

// To parse this JSON data, do
//
//     final scanModel = scanModelFromJson(jsonString);

import 'dart:convert';

ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
    ScanModel({
        this.id,
        this.value,
        this.latitude,
        this.longitude,
        this.name,
        this.description,
        this.date,
    });

    int? id;
    String? value;
    double? latitude;
    double? longitude;
    String? name;
    String? description;
    String? date;

    factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        value: json["value"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        name: json["name"],
        description: json["description"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "latitude": latitude,
        "longitude": longitude,
        "name": name,
        "description": description,
        "date": date,
    };
}
