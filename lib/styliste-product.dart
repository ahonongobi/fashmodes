import 'dart:convert';

import 'package:banque/main.dart';
import 'package:banque/src/pages/product_detail.dart';
import 'package:banque/src/widgets/extentions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:banque/product.dart';
import 'package:banque/product-api.dart';
import 'package:http/http.dart' as http;
//class StylisteProduct extends StatelessWidget {
//@override
//Widget build(BuildContext context) {
//return MaterialApp(
//title: 'Fash Modes',
//theme: new ThemeData(
//    primarySwatch: Colors.indigo,
//    fontFamily: GoogleFonts.openSans().fontFamily),
//debugShowCheckedModeBanner: false,
//home: StyleProduct(),
//);
//}
//}

class StyleProduct extends StatefulWidget {
  final String id;
  final String email;
  StyleProduct({Key key, @required this.id, this.email}) : super(key: key);
  @override
  _StyleProductState createState() => _StyleProductState(this.id, this.email);
}

class _StyleProductState extends State<StyleProduct> {
  String id;
  String email;
  List<String> imageList = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTabCvhGXYSUX8RD2qaRVrmlspfX5jJWb4ywQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ6GBk_RFrYFuHUvstSyB0PxRGA9bdT_grwOQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ6GBk_RFrYFuHUvstSyB0PxRGA9bdT_grwOQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ6GBk_RFrYFuHUvstSyB0PxRGA9bdT_grwOQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ6GBk_RFrYFuHUvstSyB0PxRGA9bdT_grwOQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ6GBk_RFrYFuHUvstSyB0PxRGA9bdT_grwOQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ6GBk_RFrYFuHUvstSyB0PxRGA9bdT_grwOQ&usqp=CAU'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    id = id;
    email = email;
  }

  Widget myProd() => FutureBuilder<List<Products>>(
        future: fetchProductStyliste(),
        builder: (context, snapshot) {
          BackButton();
          if (snapshot.hasData) {
            return StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      showPage2(
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
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          //image: imageList[index],
                          image:
                              "http://mestps.tech/upload/categories/${snapshot.data[index].images}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (index) {
                  return new StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
                });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );

  Future<List<Products>> fetchProductStyliste() async {
    String url = "http://mestps.tech/product_styliste.php";

    var data = {'idStyliste': id};
    final response = await http.post(url, body: json.encode(data));

    return productsFromJson(response.body);
  }

  _StyleProductState(this.id, this.email);
  Widget build(BuildContext context) {
    return Scaffold(
      body: myProd(),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new MyApp()));
        },
        child: Icon(Icons.arrow_back_ios),
      ),
    );
  }
}

showPage2(
  BuildContext context,
  String prix,
  String nom,
  String description,
  String images,
  String idstyliste,
  String email,
) {
  Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) => new ProductDetailPage(
            prix: prix,
            nom: nom,
            description: description,
            //idstyliste: idstyliste,
            images: images,
            idstyliste: idstyliste,
            email: email,
          )));
}
