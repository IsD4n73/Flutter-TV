import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

void getChannel() async {
  var url = Uri.parse(
      "https://raw.githubusercontent.com/IsD4n73/IsD4n73/file/channel.json");
  Response response = await http.get(url);

  Map<String, dynamic> data = jsonDecode(response.body);
  
  print(data);
}
