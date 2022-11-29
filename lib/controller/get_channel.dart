import 'dart:async';
import 'dart:convert';

import 'package:flutter_tv/commons/vars.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

void getChannel() async {
  var url = Uri.parse(
      "https://raw.githubusercontent.com/IsD4n73/IsD4n73/file/channel.json");
  Response response = await http.get(url);

  Map<String, dynamic> data = jsonDecode(response.body);
  
  print(data);
}
