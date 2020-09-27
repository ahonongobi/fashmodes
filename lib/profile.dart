import 'package:banque/signInScreen.dart';
import 'package:flutter/material.dart';
import 'package:banque/signUpScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  final String email;
  Profile({Key key, @required this.email}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState(this.email);
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = email;
  }

  String email;
  _ProfileState(this.email);
  final nameController = new TextEditingController();
  final telController = new TextEditingController();
  final addController = new TextEditingController();
  final villeController = new TextEditingController();
  final paysController = new TextEditingController();

  //final idController = email;
  //File _image;
  final picker = ImagePicker();
  bool _validateEmail = false;
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          BackButtonWidget(),
          //Container(

          //height: 300,
          //decoration: BoxDecoration(
          // image: DecorationImage(
          //fit: BoxFit.cover,
          //image: NetworkImage('https://metwo.fr/4064004.jpg'))),
          //),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.account_box), onPressed: null),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(right: 20, left: 10),
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: 'Nom',
                            errorText: _validateEmail
                                ? 'veuillez entrer l adresse'
                                : null,
                          ),
                        )))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.phone), onPressed: null),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(right: 20, left: 10),
                        child: TextField(
                          controller: telController,
                          decoration: InputDecoration(
                            hintText: 'Téléphone',
                            errorText: _validateEmail
                                ? 'veuillez entrer l adresse'
                                : null,
                          ),
                        )))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.local_activity), onPressed: null),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(right: 20, left: 10),
                        child: TextField(
                          controller: addController,
                          decoration: InputDecoration(
                            hintText: 'Adresse',
                            errorText: _validateEmail
                                ? 'veuillez entrer l adresse'
                                : null,
                          ),
                        )))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.location_city), onPressed: null),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(right: 20, left: 10),
                        child: TextField(
                          controller: villeController,
                          decoration: InputDecoration(
                            hintText: 'Ville',
                            errorText: _validateEmail
                                ? 'veuillez entrer l adresse'
                                : null,
                          ),
                        )))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.map), onPressed: null),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(right: 20, left: 10),
                        child: TextField(
                          controller: paysController,
                          decoration: InputDecoration(
                            hintText: 'Pays',
                            errorText: _validateEmail
                                ? 'veuillez entrer l adresse'
                                : null,
                          ),
                        )))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: 60,
                child: RaisedButton(
                  onPressed: _submitting,
                  color: const Color(0xFF200087),
                  child: Text(
                    'S\'INSCRIRE',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: visible,
            child: Center(
              child: Card(
                child: Container(
                  width: 80,
                  height: 80,
                  padding: EdgeInsets.all(12.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'SignUp');
            },
          )
        ],
      ),
    );
  }

  Future _submitting() async {
    setState(() {
      visible = true;
    });
    final uri = Uri.parse("http://mestps.tech/savestyliste.php");

    var request = http.MultipartRequest("POST", uri);

    request.fields['name'] = nameController.text;
    request.fields['id'] = email;
    request.fields['tele'] = telController.text;
    request.fields['adresse'] = addController.text;
    request.fields['ville'] = villeController.text;
    request.fields['pays'] = paysController.text;

    var response = await request.send();
    if (response.statusCode == 200) {
      print("succes");
      setState(() {
        visible = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(
                "votre inscription a été enregistrée avec succès. se connecter"),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new SignInScreen()));
                },
              ),
            ],
          );
        },
      );
    } else {
      print('died');
    }
  }
}
