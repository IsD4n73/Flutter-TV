import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tmdb_dart/tmdb_dart.dart';
import 'package:html/parser.dart';
import '../../commons/vars.dart';
import 'package:flutter_tv/widget/channel_list.dart';
import 'package:http/http.dart' as http;

String urlAltadefinizione =
    "https://altadefinizione.haus/index.php?do=search&subaction=search&story=";

Future<void> altadefinizioneProvider(
    BuildContext context, MovieBase movie) async {
  context.loaderOverlay.show();
  String query = movie.title.replaceAll(" ", "%20");
  query = query.replaceAll("'", "%27");

  final filmResponse = await http.get(
    Uri.parse('$urlAltadefinizione$query&sortby=news_read'),
    headers: {"user-agent": userAgent},
  );

  if (filmResponse.statusCode == 200) {
    var document = parse(filmResponse.body);
    var link = document.getElementsByClassName("titleFilm").first;

    String? filmPageUrl = link.children.first.attributes["href"];
    if (filmPageUrl != null) {
      final channelResponse = await http
          .get(Uri.parse(filmPageUrl), headers: {"user-agent": userAgent});
      if (channelResponse.statusCode == 200) {
        document = parse(channelResponse.body);
        var link = document
            .getElementsByClassName("player-container-wrap guardahd-player")
            .first
            .children
            .first
            .attributes["src"];

        if (link != null) {
          final videoResponse = await http
              .get(Uri.parse(link), headers: {"user-agent": userAgent});
          if (videoResponse.statusCode == 200) {
            document = parse(videoResponse.body);
            var links = document
                .getElementsByClassName("_player-mirrors")
                .first
                .children;
            List<String> canaliNomi = [];
            List<String?> canaliLink = [];
            for (var canale in links) {
              canaliNomi.add(canale.text);
              canaliLink.add(canale.attributes["data-link"]);
            }

            showChannelMenu(context, canaliNomi, canaliLink);
          } else {
            BotToast.showSimpleNotification(
              title:
                  "C'è stato un errore nel recuperare i link - Errore: ${videoResponse.statusCode}",
              backgroundColor: Colors.white,
            );
          }
        } else {
          BotToast.showSimpleNotification(
            title: "Non sono stati trovati link",
            backgroundColor: Colors.white,
          );
        }
      } else {
        BotToast.showSimpleNotification(
          title:
              "C'è stato un errore nel recuperare il film - Errore: ${channelResponse.statusCode}",
          backgroundColor: Colors.white,
        );
      }
    } else {
      BotToast.showSimpleNotification(
        title: "Non è stato trovato il link del film.",
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
