import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_tv/pages/film/film_view.dart';
import 'package:flutter_tv/pages/player_iptv.dart';
import 'package:flutter_tv/pages/serie/series_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../commons/vars.dart';

Widget buildList(BuildContext context, int index, var channelList) {
  FlutterNativeSplash.remove();

  return InkWell(
      onTap: () async {
        String url = channelList[index]['url'];
        if (url.endsWith(".m3u")) {
          await launchUrl(Uri.parse(url),
              mode: LaunchMode.externalNonBrowserApplication);
        } else if (url == "pagina") {
          if (channelList[index]['direzione'] == "film") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FilmPopolari()),
            );
          }else if (channelList[index]['direzione'] == "serie") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SeriePopolari()),
            );
          }
          print("Apertura pagina");
        } else if (url.endsWith(".m3u8")) {
          urlM3u8 = url;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const IPTVplayer()),
          );
        } else {
          if (!await launchUrl(Uri.parse(url), mode: LaunchMode.inAppWebView)) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Non è stao possibile aprire il linl"),
            ));
          }
        }
      },
      borderRadius: BorderRadius.circular(25),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        width: double.infinity,
        height: 110,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 70,
              height: 70,
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 3, color: secondary),
                image: DecorationImage(
                    image: NetworkImage(channelList[index]['img'] ?? noImg),
                    fit: BoxFit.fill),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    channelList[index]['nome'],
                    style: const TextStyle(
                        color: primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.tag,
                        color: secondary,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(channelList[index]['categorie'],
                          style: const TextStyle(
                              color: primary, fontSize: 13, letterSpacing: .3)),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                ],
              ),
            )
          ],
        ),
      ));
}
