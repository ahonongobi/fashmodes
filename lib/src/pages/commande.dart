// To parse this JSON data, do
//
//     final commande = commandeFromJson(jsonString);

import 'dart:convert';

List<Commande> commandeFromJson(String str) =>
    List<Commande>.from(json.decode(str).map((x) => Commande.fromJson(x)));

String commandeToJson(List<Commande> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Commande {
  Commande({
    this.the0,
    this.the1,
    this.the2,
    this.the3,
    this.the4,
    this.the5,
    this.id,
    this.iduser,
    this.nomproduit,
    this.prix,
    this.idStyliste,
    this.images,
  });

  String the0;
  String the1;
  String the2;
  String the3;
  String the4;
  String the5;
  String id;
  String iduser;
  String nomproduit;
  String prix;
  String idStyliste;
  String images;
  factory Commande.fromJson(Map<String, dynamic> json) => Commande(
        the0: json["0"],
        the1: json["1"],
        the2: json["2"],
        the3: json["3"],
        the4: json["4"],
        the5: json["5"],
        id: json["id"],
        iduser: json["iduser"],
        nomproduit: json["nomproduit"],
        prix: json["prix"],
        idStyliste: json["idStyliste"],
        images: json["images"],
      );

  Map<String, dynamic> toJson() => {
        "0": the0,
        "1": the1,
        "2": the2,
        "3": the3,
        "4": the4,
        "5": the5,
        "id": id,
        "iduser": the1,
        "nomproduit": nomproduit,
        "prix": prix,
        "idStyliste": idStyliste,
        "images": images,
      };
}
