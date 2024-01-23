// To parse this JSON data, do
//
//     final klineResponse = klineResponseFromJson(jsonString);

import 'dart:convert';

List<List<dynamic>> klineResponseFromJson(String str) =>
    List<List<dynamic>>.from(
        json.decode(str).map((x) => List<dynamic>.from(x.map((x) => x))));

String klineResponseToJson(List<List<dynamic>> data) => json.encode(
    List<dynamic>.from(data.map((x) => List<dynamic>.from(x.map((x) => x)))));
