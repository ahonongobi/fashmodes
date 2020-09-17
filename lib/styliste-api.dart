import 'styliste.dart';
import 'package:http/http.dart' as http;

Future<List<Styliste>> fetchStylistes() async {
  String url = "http://mestps.tech/styliste.php";
  final response = await http.get(url);

  return stylisteFromJson(response.body);
}
