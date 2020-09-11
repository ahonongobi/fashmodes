// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

List<dynamic> productsFromJson(String str) =>
    List<dynamic>.from(json.decode(str).map((x) => x));

String productsToJson(List<dynamic> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x)));
