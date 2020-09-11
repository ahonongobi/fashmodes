import 'dart:convert';

//import 'package:banque/categories.dart';
import 'package:flutter/cupertino.dart';

import 'product.dart';
import 'package:http/http.dart' as http;

Future<List<Products>> fetchProducts(String holder) async {
  String url = "http://mestps.tech/product_categories.php";

  var data = {'categories': holder};
  final response = await http.post(url, body: json.encode(data));

  return productsFromJson(response.body);
}
