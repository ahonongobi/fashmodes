import 'dart:convert';

import 'package:banque/categories.dart';
import 'package:flutter/material.dart';
import 'package:banque/product.dart';
import 'package:banque/product-api.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

mybody() => FutureBuilder<List<Products>>(
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
                      "http://mestps.tech/upload/categories/${snapshot.data[index].images}",
                      //"${snapshot.data[index].images}",
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

        return Center(
          child: CircularProgressIndicator(),
        );
        //return CircularProgressIndicator();
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

class _SearchState extends State<Search> {
  List<Products> product = List();
  List<Products> filteredProduct = List();

  void initSate() {
    super.initState();
    fetchProducts().then((productsFromJson) {
      product = productsFromJson;
      filteredProduct = product;
    });
  }

  final textController = TextEditingController();

  bool searching = false;
  bool isEmpty = true;
  bool visible = true;
  Future<List<Products>> fetchSearch() async {
    String value = textController.text;
    String url = "http://mestps.tech/product_search.php";

    var data = {'valeurs': value};
    //var http;

    setState(() {
      visible = false;
    });
    if (isEmpty == false) {
      final response = await http.post(url, body: json.encode(data));
      return productsFromJson(response.body);
    }
  }

  mySearch() => FutureBuilder<List<Products>>(
        future: fetchSearch(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1.0),
              //scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => InkWell(
                onTap: () {},
                child: Card(
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.network(
                        "http://mestps.tech/upload/categories/${snapshot.data[index].images}",
                        //"${snapshot.data[index].images}",
                        fit: BoxFit.cover,
                      ),

                      //Text("${snapshot.data[index].id}")
                      Positioned(
                        left: 0.0,
                        bottom: 0.0,
                        child: Container(
                          color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "${snapshot.data[index].prix}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  //return Text("${snapshot.data[index].id}");
                ),
              ),
            );
          }

          //return Text("chargement...");
          //return CircularProgressIndicator();
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF200087),
          title: !searching
              ? Text("Rechercher")
              : TextField(
                  onChanged: (value) {
                    //mySearch(value);

                    setState(() {
                      this.isEmpty = false;
                    });
                  },
                  controller: textController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    //contentPadding: EdgeInsets.only(right: 20, left: 10),
                    hintText: "Entrer cee que vous cherchez...",
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
          actions: <Widget>[
            searching
                ? IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      setState(() {
                        this.searching = false;
                        this.isEmpty = true;
                      });
                    })
                : IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        this.searching = true;
                      });
                    }),
          ],
        ),
        body: isEmpty ? mybody() : mySearch() //Container(
        //mainAxisSize: MainAxisSize.min,

        //children: <Widget>[
        //IconButton(icon: Icon(Icons.search), onPressed: null),
        //Padding(
        //padding: const EdgeInsets.all(8.0),
        //child: TextField(
        //decoration: InputDecoration(
        //contentPadding: EdgeInsets.only(right: 20, left: 10),
        //hintText: "Entrer cee que vous cherchez...",
        //),
        //),
        // ),

        // Image.network(
        // images,
        //height: 220.0,
        // ),
        //Expanded(child: isEmpty ? mybody() : mySearch(value))
        //isEmpty ? mybody() : mySearch(value),
        //mybody()
        //  ],
        // ),
        );
  }
}

loading() {
  return Container(
    child: Text("data"),
  );
}
