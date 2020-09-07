import 'product.dart';
import 'package:http/http.dart' as http;

Future<List<Products>> fetchProducts() async {
  String url = "http://mestps.tech/product.php";
  final response = await http.get(url);

  return productsFromJson(response.body);
}
