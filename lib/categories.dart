import 'dart:convert';

//import 'package:banque/product-api.dart';
//import 'package:banque/main.dart';
import 'package:banque/product.dart';
import 'package:carousel_pro/carousel_pro.dart';
//import 'package:banque/productcategories-api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Categories extends StatefulWidget {
  final String categories;
  final String id;
  final String images;
  Categories({Key key, @required this.categories, this.id, this.images})
      : super(key: key);

  @override
  _CategoriesState createState() =>
      _CategoriesState(this.categories, this.id, this.images);
  //final Produit produit;
}

class _CategoriesState extends State<Categories> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = categories;
    id = id;
    images = images;
  }

  String categories;
  String id;
  String images;
  _CategoriesState(this.categories, this.id, this.images);
  Future<List<Products>> fetchProducts() async {
    String url = "http://mestps.tech/product_categories.php";

    var data = {'categories': categories};
    final response = await http.post(url, body: json.encode(data));

    return productsFromJson(response.body);
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
                onTap: () {},
                child: Card(
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.network(
                        "${snapshot.data[index].images}",
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

          return Text("chargement...");
          //return CircularProgressIndicator();
        },
      );
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF200087),
        title: new Text('Categories'),
      ),
      body: Column(
        //mainAxisSize: MainAxisSize.min,

        children: <Widget>[
          Container(
            height: 250,
            child: Carousel(
              boxFit: BoxFit.fill,
              images: [
                NetworkImage(
                  images,
                ),
                NetworkImage(
                  images,
                ),
                NetworkImage(
                  images,
                )
              ],
            ),
          ),

          // Image.network(
          // images,
          //height: 220.0,
          // ),

          const ListTile(
            leading: Icon(Icons.shopping_cart, size: 50),
            title: Text('Heart Shaker'),
            subtitle: Text('500F'),
          ),
          RaisedButton(
            elevation: 8.0,
            onPressed: null,
            child: Text(
              "Commander",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(child: mybody())
        ],
      ),
    );
  }
}
