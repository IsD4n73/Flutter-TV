import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

const TextStyle dropdownMenuItem = TextStyle(color: Colors.black, fontSize: 18);

const primary = Color.fromARGB(255, 114, 158, 105);
const secondary = Color.fromARGB(255, 114, 158, 105);

Future<String> getChannels() async {
  var url = Uri.parse(
      "https://raw.githubusercontent.com/IsD4n73/IsD4n73/file/channel.json");
  Response response = await http.get(url);

  String data = response.body;
  

  return data;
}




