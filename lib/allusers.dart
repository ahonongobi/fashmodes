// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

List<Users> usersFromJson(String str) =>
    List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  Users({
    this.the0,
    this.the1,
    this.the2,
    this.the3,
    this.the4,
    this.the5,
    this.id,
    this.typeuser,
    this.mdp,
    this.email,
    this.numero,
    this.profileimages,
  });

  String the0;
  String the1;
  String the2;
  String the3;
  String the4;
  String the5;
  String id;
  String typeuser;
  String mdp;
  String email;
  String numero;
  String profileimages;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        the0: json["0"],
        the1: json["1"],
        the2: json["2"],
        the3: json["3"],
        the4: json["4"],
        the5: json["5"],
        id: json["id"],
        typeuser: json["typeuser"],
        mdp: json["mdp"],
        email: json["email"],
        numero: json["numero"],
        profileimages: json["profileimages"],
      );

  Map<String, dynamic> toJson() => {
        "0": the0,
        "1": the1,
        "2": the2,
        "3": the3,
        "4": the4,
        "5": the5,
        "id": id,
        "typeuser": typeuser,
        "mdp": mdp,
        "email": email,
        "numero": numero,
        "profileimages": profileimages,
      };
}
