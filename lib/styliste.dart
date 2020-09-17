// To parse this JSON data, do
//
//     final styliste = stylisteFromJson(jsonString);

import 'dart:convert';

List<Styliste> stylisteFromJson(String str) =>
    List<Styliste>.from(json.decode(str).map((x) => Styliste.fromJson(x)));

String stylisteToJson(List<Styliste> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Styliste {
  Styliste({
    this.the0,
    this.the1,
    this.the2,
    this.the3,
    this.the4,
    this.the5,
    this.the6,
    this.the7,
    this.id,
    this.idstyliste,
    this.nom,
    this.telephone,
    this.ville,
    this.adresse,
    this.pays,
    this.photo,
  });

  String the0;
  String the1;
  String the2;
  String the3;
  String the4;
  String the5;
  String the6;
  String the7;
  String id;
  String idstyliste;
  String nom;
  String telephone;
  String ville;
  String adresse;
  String pays;
  String photo;

  factory Styliste.fromJson(Map<String, dynamic> json) => Styliste(
        the0: json["0"],
        the1: json["1"],
        the2: json["2"],
        the3: json["3"],
        the4: json["4"],
        the5: json["5"],
        the6: json["6"],
        the7: json["7"],
        id: json["id"],
        idstyliste: json["idstyliste"],
        nom: json["nom"],
        telephone: json["telephone"],
        ville: json["ville"],
        adresse: json["adresse"],
        pays: json["pays"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "0": the0,
        "1": the1,
        "2": the2,
        "3": the3,
        "4": the4,
        "5": the5,
        "6": the6,
        "7": the7,
        "id": id,
        "idstyliste": idstyliste,
        "nom": nom,
        "telephone": telephone,
        "ville": ville,
        "adresse": adresse,
        "pays": pays,
        "photo": photo,
      };
}
