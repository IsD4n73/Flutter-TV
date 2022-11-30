
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<String> getChannels() async {
  var url = Uri.parse(
      "https://raw.githubusercontent.com/IsD4n73/IsD4n73/file/channel.json");
  Response response = await http.get(url);

  String data = response.body;

  return data;
}
