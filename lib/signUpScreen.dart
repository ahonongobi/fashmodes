import 'dart:io';

import 'package:banque/signInScreen.dart';
import 'package:banque/profile.dart';
import 'package:banque/src/widgets/extentions.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

//import 'package:banque/Animation/FadeAnimation.dart';
void main() => runApp(SignUpScreen());

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  List<String> cities = [
    'styliste',
    'simple',
  ];
  final textController = new TextEditingController();
  final passwordController = new TextEditingController();
  final emailController = new TextEditingController();
  final numeroController = new TextEditingController();
  RegExp regex = new RegExp(r'^[1-9]\d*(\.\d+)?$');
  RegExp regexEmail = new RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  bool _validate = false;
  bool _validatePassword = false;
  bool _validateEmail = false;
  bool _validateNumero = false;
  bool visible = false;
  File _image;
  final picker = ImagePicker();
  Future choiceImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    Future _submiting() async {
      setState(() {
        textController.text.isEmpty ? _validate = true : _validate = false;
        (passwordController.text.length) < 5
            ? _validatePassword = true
            : _validatePassword = false;
        numeroController.text.isEmpty
            ? _validateNumero = true
            : _validateNumero = false;
        emailController.text.isEmpty
            ? _validateEmail = true
            : _validateEmail = false;

        _validatePassword || _validateEmail || _validateNumero || _validate
            ? visible = false
            : visible = true;
        // _validateEmail ? visible = false : visible = true;
        //_validateNumero ? visible = false : visible = true;
        //_validate ? visible = false : visible = true;
      });
      String username = textController.text;
      String password = passwordController.text;
      String email = emailController.text;
      String numero = numeroController.text;

      // SERVER API URL
      var url = 'http://mestps.tech/register_user.php';

      // Store all data with Param Name.
      var data = {
        'username': username,
        'email': email,
        'mdp': password,
        'numero': numero,
      };
      if (visible == true) {
        // Starting Web API Call.
        var response = await http.post(url, body: json.encode(data));

        // Getting Server response into variable.
        var message = jsonDecode(response.body);

        // If Web call Success than Hide the CircularProgressIndicator.
        if (response.statusCode == 200) {
          uploadImgae();
          setState(() {
            visible = false;
          });
          if (username == "styliste") {
            styleadd(context, email);
          } else {
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
                            builder: (BuildContext context) =>
                                new SignInScreen()));
                      },
                    ),
                  ],
                );
              },
            );
          }
        }
        // Showing Alert Dialog with Response JSON Message.
        //showDialog(
        //context: context,
        //builder: (BuildContext context) {
        //return AlertDialog(
        // title: new Text(message),
        //actions: <Widget>[
        //  FlatButton(
        // child: new Text("OK"),
        // onPressed: () {
        // styleadd(context, email);
        //  },
        // ),
        // ],
        // );
        // },
        // );
      }
    }

    backGobi() {}

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Stack(children: <Widget>[
            Image.network(
                "https://images.unsplash.com/photo-1541256942802-7b29531f0df8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjExMzk2fQ&auto=format&fit=crop&w=500&q=60"),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Center(
                child: Text("CREER UN NOUVEAU COMPTE",
                    style: TextStyle(color: Colors.white, fontSize: 20.0)),
              ),
            )
          ]),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.person), onPressed: null),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(right: 20, left: 10),
                        child: DropDownField(
                          controller: textController,
                          required: true,
                          hintText: 'Type d\'inscription',
                          //labelText: 'Type d\'inscription',
                          items: cities,
                        )))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.lock), onPressed: null),
                Expanded(
                    child: new Column(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(right: 20, left: 10),
                        child: TextField(
                          obscureText: true,
                          controller: passwordController,
                          onChanged: (value) {
                            !(value.length > 5) && value.isNotEmpty
                                ? _validatePassword = true
                                : _validatePassword = false;
                            setState(() {});
                          },
                          decoration: InputDecoration(
                              hintText: 'Mot de passe',
                              errorText: _validatePassword
                                  ? "Password should contains more then 5 character"
                                  : null),
                        ))
                  ],
                ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.mail), onPressed: null),
                Expanded(
                    child: new Column(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(right: 20, left: 10),
                        child: TextField(
                          onChanged: (value) {
                            if (!(regexEmail.hasMatch(value))) {
                              _validateEmail = true;
                            } else {
                              _validateEmail = false;
                            }
                            setState(() {});
                          },
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: 'Email',
                              errorText:
                                  _validateEmail ? 'Email invalide' : null),
                        ))
                  ],
                ))
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
                          onChanged: (value) {
                            if (!(regex.hasMatch(value))) {
                              _validateNumero = true;
                            } else {
                              _validateNumero = false;
                            }
                            setState(() {});
                          },
                          keyboardType: TextInputType.phone,
                          controller: numeroController,
                          decoration: InputDecoration(
                              hintText: 'Numero de telephone',
                              errorText:
                                  _validateNumero ? 'numero invalide' : null),
                        )))
              ],
            ),
          ),
          IconButton(
              icon: Icon(Icons.file_upload),
              onPressed: () {
                choiceImage();
              }),
          Container(
              padding: EdgeInsets.only(left: 50.0, right: 30.0),
              child: _image == null
                  ? Text(
                      "pas d'image selectionéé ",
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    )
                  : Image.file(_image)),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Radio(value: null, groupValue: null, onChanged: null),
                RichText(
                    text: TextSpan(
                        text: 'J\'accepte les ',
                        style: TextStyle(color: Colors.black),
                        children: [
                      TextSpan(
                          text: 'Termes & Conditions',
                          style: TextStyle(
                              color: Colors.teal, fontWeight: FontWeight.bold))
                    ]))
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: 60,
                child: RaisedButton(
                  onPressed: _submiting,
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
        ],
      ),
    );
  }

  Future uploadImgae() async {
    final uri = Uri.parse("http://mestps.tech/registerProfile_user.php");
    var request = http.MultipartRequest("POST", uri);
    request.fields['email'] = emailController.text;
    var pic = await http.MultipartFile.fromPath("image", _image.path);
    request.files.add(pic);

    var response = await request.send();
    if (response.statusCode == 200) {
      print("succes");
    } else {
      print('died');
    }
  }

  styleadd(BuildContext context, String email) {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new Profile(
              email: email,
            )));
  }
}

Widget backButtonWidgetSuper(BuildContext context) {
  return Container(
    height: 200,
    decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                'https://images.unsplash.com/photo-1541256942802-7b29531f0df8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjExMzk2fQ&auto=format&fit=crop&w=500&q=60'))),
    child: Positioned(
        child: Stack(
      children: <Widget>[
        Positioned(
            top: 20,
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                Text(
                  'Back',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )
              ],
            )),
        Positioned(
          bottom: 20,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Creer un nouveau compte',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        )
      ],
    )),
  );
}

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1541256942802-7b29531f0df8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjExMzk2fQ&auto=format&fit=crop&w=500&q=60'))),
      child: Positioned(
          child: Stack(
        children: <Widget>[
          Positioned(
              top: 20,
              child: Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  Text(
                    'Back',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              )),
          Positioned(
            bottom: 20,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Creer un nouveau compte',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          )
        ],
      )),
    );
  }
}

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  LoadingDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
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
    );
  }
}
