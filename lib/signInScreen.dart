import 'package:banque/after_login.dart';
//import 'package:banque/main.dart';
import 'package:banque/signUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:flutter/gestures.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyAppHome());

class MyAppHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Fash Modes',
      theme: new ThemeData(
          primarySwatch: Colors.indigo,
          fontFamily: GoogleFonts.openSans().fontFamily),
      debugShowCheckedModeBanner: false,
      home: new SignInScreen(),
      //routes: <String, WidgetBuilder>{
      // "/a": (BuildContext context) => SignInScreen("New page")
      //},
    );
  }
}

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key key}) : super(key: key);
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  //Widget myForm() {}
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  bool _validatePassword = false;
  bool _validateEmail = false;
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    Future _submiting() async {
      setState(() {
        emailController.text.isEmpty
            ? _validateEmail = true
            : _validateEmail = false;
        passwordController.text.isEmpty
            ? _validatePassword = true
            : _validatePassword = false;
        _validatePassword || _validateEmail ? visible = false : visible = true;
      });
      String email = emailController.text;
      String password = passwordController.text;
      // SERVER API URL
      var url = 'http://mestps.tech/login_user.php';

      // Store all data with Param Name.
      var data = {
        'email': email,
        'mdp': password,
      };
      // Starting Web API Call.
      if (visible == true) {
        var response = await http.post(url, body: json.encode(data));

        // Getting Server response into variable.
        var message = jsonDecode(response.body);
        // If the Response Message is Matched.
        if (message == 'Login Matched') {
          // Hiding the CircularProgressIndicator.
          setState(() {
            visible = false;
          });

          // Navigate to Profile Screen & Sending Email to Next Screen.
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new AfterLogin(
                    email: emailController.text,
                  )));
        } else {
          // If Email or Password did not Matched.
          // Hiding the CircularProgressIndicator.
          setState(() {
            visible = false;
          });
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text(message),
                actions: <Widget>[
                  FlatButton(
                    child: new Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          // BackButtonWidget(),
          //Container(

          //height: 300,
          //decoration: BoxDecoration(
          // image: DecorationImage(
          //fit: BoxFit.cover,
          //image: NetworkImage('https://metwo.fr/4064004.jpg'))),
          //),
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
                child: Text("CONNECTEZ VOUS A LA PLATEFORME",
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
                IconButton(icon: Icon(Icons.email), onPressed: null),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(right: 20, left: 10),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              errorText: _validateEmail
                                  ? 'veuillez entrer l adresse'
                                  : null,
                            ),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.lock), onPressed: null),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(right: 20, left: 10),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Mot de passe',
                              errorText:
                                  _validatePassword ? 'password vide' : null,
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: 60,
                child: RaisedButton(
                  onPressed: _submiting,
                  color: Colors.indigo,
                  child: Text(
                    'SE CONNECTER',
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
            child: Center(
              child: RichText(
                text: TextSpan(
                    text: 'Vous n\'avez pas encore de compte?',
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'S\'inscrire',
                        style: TextStyle(
                            color: Colors.teal, fontWeight: FontWeight.bold),
                      )
                    ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
