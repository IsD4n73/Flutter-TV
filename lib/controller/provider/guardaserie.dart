import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tmdb_dart/tmdb_dart.dart';
import 'package:html/parser.dart';
import '../../commons/vars.dart';
import 'package:flutter_tv/widget/channel_list.dart';
import 'package:http/http.dart' as http;

String urlGuardaserie =
    "https://guardaserie.one/index.php?do=search&subaction=search&story=";
String urlGuardaserieShort = "https://guardaserie.one";

Future<void> guardaserieProvider(
    BuildContext context, TvBase movie, int episode, String season) async {
  context.loaderOverlay.show();

  String query = movie.name.replaceAll(" ", "%20");
  query = query.replaceAll("'", "%27");

  final filmResponse = await http.get(
    Uri.parse('$urlGuardaserie$query'),
    headers: {"user-agent": userAgent},
  );

  if (filmResponse.statusCode == 200) {
    var document = parse(filmResponse.body);
    var link = document.getElementsByClassName("mlnew-list");

    String? linkPage;

    for (var tile in link) {
      for (var anchor in tile.querySelectorAll("a").where(
            (element) => element.text.contains(movie.name),
          )) {
        linkPage = anchor.attributes["href"];
      }
    }

    if (linkPage != null) {
      final pageResponse = await http.get(
        Uri.parse(linkPage),
        headers: {"user-agent": userAgent},
      );
      var doc = parse(pageResponse.body);

      try {
        var episodes = doc.getElementsByClassName("tt_series").first;
        var episodesSeason = episodes.children.last.children;

        var seasonLinks = episodesSeason
            .where((element) => element.attributes["id"] == "season-$season");

        var links = seasonLinks.first.children.first.children
            .where((element) => element.children.first.text == "$episode")
            .first
            .children
            .last
            .children;

        List<String> canaliNomi = [];
        List<String?> canaliLink = [];

        canaliNomi = links.map((e) => e.text).toList();
        canaliLink = links.map((e) {
          if (e.attributes["data-link"] == null) {
            return urlGuardaserie;
          } else {
            if (e.attributes["data-link"]!.contains("http")) {
              return e.attributes["data-link"];
            } else {
              return "$urlGuardaserieShort${e.attributes["data-link"]}";
            }
          }
        }).toList();

        showChannelMenu(context, canaliNomi, canaliLink);
      } catch (_) {
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
