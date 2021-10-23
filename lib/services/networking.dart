import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final String? url;
  NetworkHelper(this.url);

  Future getData() async {
    var uri = Uri.parse(url!);
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
