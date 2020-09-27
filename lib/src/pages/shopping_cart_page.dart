import 'dart:convert';

import 'package:banque/src/pages/commande.dart';
import 'package:flutter/material.dart';
import 'package:banque/src/model/data.dart';
import 'package:banque/src/model/product.dart';
import 'package:banque/src/themes/light_color.dart';
import 'package:banque/src/themes/theme.dart';
import 'package:banque/src/widgets/title_text.dart';
import 'package:banque/src/pages/product_detail.dart';
import 'package:http/http.dart' as http;
import '../../product.dart';

class ShoppingCartPage extends StatefulWidget {
  final String email;
  ShoppingCartPage({Key key, @required this.email}) : super(key: key);

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  Future<List<Commande>> fetchCommandes() async {
    String url = "http://mestps.tech/shopingCart.php";

    var data = {'email': widget.email};
    final response = await http.post(url, body: json.encode(data));

    return commandeFromJson(response.body);
  }

  Future<List<Commande>> fetchShoppingSum() async {
    String url = "http://mestps.tech/shoppingCartSum.php";

    var data = {'email': widget.email};
    final response = await http.post(url, body: json.encode(data));

    return commandeFromJson(response.body);
  }

  Widget _cartItems() => FutureBuilder<List<Commande>>(
        future: fetchCommandes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          // if (snapshot.hasData) {
          return ListView(
            children: snapshot.data
                .map(
                  (data) => Column(
                    children: [
                      Container(
                        height: 80,
                        child: Row(
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 1.2,
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      child: Stack(
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: LightColor.lightGrey,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: -30,
                                    bottom: -20,
                                    child: Image.network(
                                      "http://mestps.tech/upload/categories/${data.images}",
                                      width: 226,
                                      height: 172,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                                child: ListTile(
                              title: TitleText(
                                text: data.nomproduit,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                              subtitle: Row(
                                children: <Widget>[
                                  TitleText(
                                    text: '\$ ',
                                    color: LightColor.red,
                                    fontSize: 12,
                                  ),
                                  TitleText(
                                    //text: model.price.toString(),
                                    text: data.prix,
                                    fontSize: 14,
                                  ),
                                ],
                              ),
                              trailing: Container(
                                width: 35,
                                height: 35,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: LightColor.lightGrey.withAlpha(150),
                                    borderRadius: BorderRadius.circular(10)),
                                //child: TitleText(
                                //text: 'x${data.id}',
                                //  text: 'x2',
                                //  fontSize: 12,
                                //),
                                child: Icon(Icons.delete),
                              ),
                            ))
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          );
          // }

          //return Text("chargement...");
        },
      );
  Widget _submitButton(BuildContext context) {
    return FlatButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: LightColor.orange,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 12),
          width: AppTheme.fullWidth(context) * .7,
          child: TitleText(
            text: 'Payer',
            color: LightColor.background,
            fontWeight: FontWeight.w500,
          ),
        ));
  }

  double getPrice() {
    double price = 0;

    AppData.cartList.forEach((x) {
      price += x.price * x.id;
    });
    return price;
  }

  Widget _price() => FutureBuilder<List<Commande>>(
      future: fetchShoppingSum(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TitleText(
              //text: '${AppData.cartList.length} Items',
              text: "Totaux:",
              color: LightColor.grey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            TitleText(
              //text: '\$${getPrice()}',
              text: '${snapshot.data[0].prix}\FCFA',
              fontSize: 18,
            ),
          ],
        );
      });

  Widget _deleteCart() {
    return FlatButton(
      onPressed: () {},
      child: Text(
        "Payer",
        style: TextStyle(color: Colors.white),
      ),
      color: Colors.indigo,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Fash Modes"),
      ),
      body: Container(
        child: Container(
          padding: AppTheme.padding,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: _deleteCart(),
              ),
              Divider(
                thickness: 1,
                height: 100,
              ),
              _price(),
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: _cartItems(),
              ),
              SizedBox(height: 30),
              //FlatButton(onPressed: () {}, child: Text("Payer"))
            ],
          ),
        ),
      ),
    );
  }
}
