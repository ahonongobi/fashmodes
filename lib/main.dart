import 'package:banque/categories.dart';
import 'package:banque/new_page.dart'; //for signin screeen
import 'package:banque/register_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:banque/product.dart';
import 'package:banque/product-api.dart';

import 'package:url_launcher/url_launcher.dart';

//import 'package:cached_network_image/cached_network_image.dart';
void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Fash Modes',
      theme: new ThemeData(
          primarySwatch: Colors.indigo,
          fontFamily: GoogleFonts.openSans().fontFamily),
      debugShowCheckedModeBanner: false,
      home: new Home(),
      //routes: <String, WidgetBuilder>{
      // "/a": (BuildContext context) => SignInScreen("New page")
      //},
    );
  }
}

Widget _currentPage;
void handleClick() {}
Widget slider = Container(
  child: Text("data"),
);
Widget page0 = FutureBuilder<List<Products>>(
  future: fetchProducts(),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1.0),
        itemCount: snapshot.data.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            showPage(context, snapshot.data[index].categories,
                snapshot.data[index].id, snapshot.data[index].images);
          },
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 10.8,
            //shadowColor: Colors.amber,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.network(
                  "${snapshot.data[index].images}",
                  fit: BoxFit.cover,
                ),

                //Text("${snapshot.data[index].id}")
                Positioned(
                  right: 0.0,
                  top: 20.0,
                  child: Container(
                    height: 30.0,
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "${snapshot.data[index].prix}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0.0,
                  bottom: 0.0,
                  child: Container(
                    child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                        )),
                  ),
                )
              ],
            ),
            //return Text("${snapshot.data[index].id}");
          ),
        ),
      );
    }

    //return Text("loading");
    return CircularProgressIndicator();
  },
);

showPage(BuildContext context, String holder, String id, String images) {
  Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) => new Categories(
            categories: holder,
            id: id,
            images: images,
          )));
}

Widget page1 = GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2, childAspectRatio: 1.0),
  itemCount: 8,
  itemBuilder: (context, index) => Card(
    child: Stack(
      children: <Widget>[
        Image.network(
            "https://e-commercemakebygobi.netlify.app/img/product-2.png")
      ],
    ),
  ),
);
Widget page3 = FutureBuilder<List<Products>>(
  future: fetchProducts(),
  builder: (context, snapshot) {
    if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

    return ListView(
      children: snapshot.data
          .map((data) => Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      selectedItem(context, data.nom);
                    },
                    child: Row(children: [
                      Container(
                          width: 200,
                          height: 100,
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                "${data.styliste}",
                                width: 200,
                                height: 100,
                                fit: BoxFit.cover,
                              ))),
                      FloatingActionButton(
                        child: Icon(Icons.phone),
                        onPressed: () {
                          _calling();
                        },
                        backgroundColor: const Color(0xFF200087),
                      ),
                      Flexible(
                          child:
                              Text(data.nom, style: TextStyle(fontSize: 18))),
                    ]),
                  ),
                  Divider(color: Colors.black),
                ],
              ))
          .toList(),
    );
  },
);

selectedItem(BuildContext context, String holder) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text(holder),
        actions: <Widget>[
          FloatingActionButton(
              onPressed: null,
              child: Icon(Icons.mail),
              backgroundColor: const Color(0xFF200087)),
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

_calling() async {
  const url = 'tel:+12345678';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Widget page2 = GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2, childAspectRatio: 1.0),
  itemCount: 5,
  itemBuilder: (context, index) => Card(
    color: Colors.green,
  ),
);
Widget pageL = GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 1, childAspectRatio: 1.0),
  itemCount: 2,
  itemBuilder: (context, index) => Card(
    color: Colors.red,
  ),
);

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _pages = [page0, page2, page3];
    _currentPage = page0;
  }

  void changeTab(int index) {
    setState(() {
      _pages = [page0, page2, page3];
      _currentIndex = index;
      _currentPage = _pages[index];
    });
  }

  void handleClick(String value) {
    switch (value) {
      case 'Connexion':
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new SignInScreen()));

        break;
      case 'Inscription':
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new SignUpScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    //context = _context; // Creating String Var to Hold sent Email.

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: const Color(0xFF200087),
        title: new Text('Fash Modes'),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share, color: Colors.white),
            onPressed: () {
              Share.share('check out my app playstor app link');
            },
          ),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Connexion', 'Inscription', 'Paramètre'}
                  .map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("abyssinie"),
              accountEmail: new Text("abyssiniea@gmail.com"),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.orange,
                child: new Text("A"),
              ),
              // otherAccountsPictures: <Widget>[
              //new CircleAvatar(
              // backgroundColor: Colors.orange,
              //child: new Text("G"),
              // )
              //],
            ),
            new ListTile(
              title: new Text("Acceuil"),
              leading: new Icon(Icons.home),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            new ListTile(
              title: new Text("Nouveauté"),
              leading: new Icon(Icons.new_releases),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new SignInScreen()));
              },
            ),
            new ListTile(
              title: new Text("Inscription"),
              leading: new Icon(Icons.account_box),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new SignUpScreen()));
              },
            ),
            new ListTile(
              leading: new Icon(Icons.account_box),
              title: new Text("Connexion"),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new SignInScreen()));
              },
            ),
            new Divider(),
            new ListTile(
              title: new Text("close"),
              trailing: new Icon(Icons.close),
              onTap: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
      body: _currentPage,
      floatingActionButton: SpeedDial(
        closeManually: true,
        backgroundColor: const Color(0xFF200087),
        overlayColor: Colors.red,
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            backgroundColor: const Color(0xFF200087),
            child: Icon(Icons.explore),
            label: "Explorer",
            onTap: () => print('Explorer'),
          ),
          SpeedDialChild(
            backgroundColor: const Color(0xFF200087),
            child: Icon(Icons.search),
            label: "Rechercher",
            onTap: () => print('Rechercher'),
          ),
          SpeedDialChild(
            backgroundColor: const Color(0xFF200087),
            child: Icon(Icons.add),
            label: "Ajouter",
            onTap: () => print('Ajouter'),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF200087),
        items: [
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.home,
              color: Colors.white,
            ),
            title:
                new Text('Acceuil', style: new TextStyle(color: Colors.white)),
          ),
          BottomNavigationBarItem(
              icon: new Icon(
                Icons.new_releases,
                color: Colors.white,
              ),
              title: new Text(
                'A la mode',
                style: new TextStyle(
                  color: Colors.white,
                ),
              )),
          BottomNavigationBarItem(
              icon: new Icon(
                Icons.style,
                color: Colors.white,
              ),
              title: new Text('styliste',
                  style: new TextStyle(color: Colors.white))),
        ],
        onTap: (index) => changeTab(index),
        currentIndex: _currentIndex,
      ),
    );
  }
}
