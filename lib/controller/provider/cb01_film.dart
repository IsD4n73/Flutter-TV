import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tmdb_dart/tmdb_dart.dart';
import 'package:html/parser.dart';
import '../../commons/vars.dart';
import 'package:flutter_tv/widget/channel_list.dart';
import 'package:http/http.dart' as http;

String urlCB01 = "https://cb01.institute/?s=";

Future<void> cb01FilmProvider(BuildContext context, MovieBase movie) async {
  context.loaderOverlay.show();

  String query = movie.title.replaceAll(" ", "+");
  query = query.replaceAll("'", "%27");

  final filmResponse = await http.get(
    Uri.parse('$urlCB01$query'),
    headers: {"user-agent": userAgent},
  );

  if (filmResponse.statusCode == 200) {
    var document = parse(filmResponse.body);
    var link = document.getElementsByClassName("sequex-one-columns");

    String? linkPage;

    for (var tile in link) {
      for (var anchor in tile.querySelectorAll("a").where(
            (element) => element.text.contains(movie.title),
          )) {
        linkPage = anchor.attributes["href"];
      }
    }

    print(linkPage);

    if (linkPage != null) {
      final pageResponse = await http.get(
        Uri.parse(linkPage),
        headers: {"user-agent": userAgent},
      );
      var doc = parse(pageResponse.body);

      try {} catch (_) {
        BotToast.showSimpleNotification(
          title: "Non sono stati trovati link a questo episodio",
          backgroundColor: Colors.white,
        );
      }

      ///
    } else {
      BotToast.showSimpleNotification(
        title: "Non è stata trovata la pagina della serie",
        backgroundColor: Colors.white,
      );
    }
  } else {
    BotToast.showSimpleNotification(
      title:
          "C'è stato un errore nel recuperare il film - Errore: ${filmResponse.statusCode}",
      backgroundColor: Colors.white,
    );
  }
  context.loaderOverlay.hide();
}
