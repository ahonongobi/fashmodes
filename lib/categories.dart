import 'dart:convert';

//import 'package:banque/product-api.dart';
//import 'package:banque/main.dart';
import 'package:banque/product.dart';
import 'package:banque/src/pages/product_detail.dart';
import 'package:carousel_pro/carousel_pro.dart';
//import 'package:banque/productcategories-api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:snapping_page_scroll/snapping_page_scroll.dart';

class Categories extends StatefulWidget {
  final String categories;
  final String id;
  final String images;
  final String description;
  final String idstyliste;
  final String email;
  Categories(
      {Key key,
      @required this.categories,
      this.id,
      this.images,
      this.description,
      this.idstyliste,
      this.email})
      : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState(this.categories, this.id,
      this.images, this.description, this.idstyliste, this.email);
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
    description = description;
    idstyliste = idstyliste;
    email = email;
  }

  String categories;
  String id;
  String images;
  String description;
  String idstyliste;
  String email;
  _CategoriesState(this.categories, this.id, this.images, this.description,
      this.idstyliste, this.email);
  Future<List<Products>> fetchProducts() async {
    String url = "http://mestps.tech/product_categories.php";

    var data = {'categories': categories};
    final response = await http.post(url, body: json.encode(data));

    return productsFromJson(response.body);
  }

  Widget widget2() {
    return Container(
      height: 250,
      child: Carousel(
        boxFit: BoxFit.fill,
        images: [
          NetworkImage(
            "http://mestps.tech/upload/categories/$images",
            // images,
          ),
          NetworkImage(
            "http://mestps.tech/upload/categories/$images",
          ),
          NetworkImage(
            "http://mestps.tech/upload/categories/$images",
          )
        ],
      ),
    );
  }

  Widget mybody() => FutureBuilder<List<Products>>(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1.0),
              //scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  showPage(
                    context,
                    snapshot.data[index].prix,
                    snapshot.data[index].nom,
                    //snapshot.data[index].id,

                    snapshot.data[index].description,
                    snapshot.data[index].images,
                    snapshot.data[index].id_styliste,
                    email,
                  );
                },
                child: Card(
                  child: Stack(
                    //fit: StackFit.expand,
                    children: <Widget>[
                      Image.network(
                        "http://mestps.tech/upload/categories/${snapshot.data[index].images}",
                        //"${snapshot.data[index].images}",
                        fit: BoxFit.cover,
                      ),

                      //Text("${snapshot.data[index].id}")
                      Positioned(
                        right: 0.0,
                        bottom: 0.0,
                        child: Container(
                          height: 40.0,
                          color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "${snapshot.data[index].prix}\FCFA",
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
      body: ListView(
        children: <Widget>[
          //SizedBox(
          //height: MediaQuery.of(context).size.height * .25,
          //child: widget2(),
          //),
          widget2(),
          mybody(),
        ],
      ),
    );
  }
}

showPage(BuildContext context, String prix, String nom, String description,
    String images, String idstyliste, String email) {
  Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) => new ProductDetailPage(
            prix: prix,
            nom: nom,
            description: description,
            images: images,
            idstyliste: idstyliste,
            email: email,
          )));
}
