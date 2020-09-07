// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

List<Products> productsFromJson(String str) => List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
    Products({
        this.the0,
        this.the1,
        this.the2,
        this.the3,
        this.id,
        this.nom,
        this.prix,
        this.images,
    });

    String the0;
    String the1;
    String the2;
    String the3;
    String id;
    String nom;
    String prix;
    String images;

    factory Products.fromJson(Map<String, dynamic> json) => Products(
        the0: json["0"],
        the1: json["1"],
        the2: json["2"],
        the3: json["3"],
        id: json["id"],
        nom: json["nom"],
        prix: json["prix"],
        images: json["images"],
    );

    Map<String, dynamic> toJson() => {
        "0": the0,
        "1": the1,
        "2": the2,
        "3": the3,
        "id": id,
        "nom": nom,
        "prix": prix,
        "images": images,
    };
}
