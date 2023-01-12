import 'dart:convert';

import 'package:flutter_tv/commons/vars.dart';
import 'package:flutter_tv/model/episodio_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tv/model/season_model.dart';

Future<SeasonModel> fetchEpisode(int id) async {
  final response =
      await http.get(Uri.parse("$urlTv$id?api_key=$apiKey&language=it"));

  if (response.statusCode == 200) {
    return SeasonModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load season');
  }
}

Future<List<EpisodioModel>> fetchListEpisode(int id, String? season) async {
  season = season ?? "1";
  season = season.replaceAll("Stagione ", "");
  final response =
      await http.get(Uri.parse("$urlTv$id/season/$season?api_key=$apiKey&language=it"));

  if (response.statusCode == 200) {
    List<EpisodioModel> list = [];
    var ris = jsonDecode(response.body);

    for (var episodio in ris["episodes"]) {
      list.add(EpisodioModel(episodio["episode_number"], episodio["name"],
          "https://image.tmdb.org/t/p/w500/${episodio["still_path"]}"));
    }

    return list;
  } else {
    throw Exception('Failed to load episodes');
  }
}
