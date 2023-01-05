// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:ui' as ui;
import 'package:flutter_tv/widget/channel_list.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_tv/commons/vars.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tmdb_dart/tmdb_dart.dart';
import 'package:html/parser.dart';

class MoviePage extends StatelessWidget {
  final MovieBase movie;

  const MoviePage(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: LoaderOverlay(
          overlayColor: Colors.black,
          overlayOpacity: 0.8,
          child: ListView(
            children: <Widget>[
              MovieThumbnail(movie.backdropPath),
              MovieHeaderWithPoster(movie),
              const HorizontalLine(),
              MoviePeople(movie),
              MovieFeedback(movie),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieThumbnail extends StatelessWidget {
  final String? thumbnail;

  const MovieThumbnail(this.thumbnail, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 1),
              child: Image.network(thumbnail!),
            ),
            // const Icon(
            //   Icons.play_circle_outline,
            //   size: 100,
            //   color: Colors.white,
            // ),
          ],
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [ui.Color.fromARGB(17, 114, 158, 105), bgColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          height: 80,
        )
      ],
    );
  }
}

class MovieHeaderWithPoster extends StatelessWidget {
  final MovieBase movie;

  const MovieHeaderWithPoster(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          MoviePoster(movie.posterPath!),
          const SizedBox(width: 16),
          Expanded(
            child: MovieHeader(movie),
          ),
        ],
      ),
    );
  }
}

class MoviePoster extends StatelessWidget {
  final String poster;

  const MoviePoster(this.poster, {super.key});

  @override
  Widget build(BuildContext context) {
    var borderRadius = const BorderRadius.all(Radius.circular(10));
    return Card(
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      elevation: 8,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Image.network(
          poster,
          height: 160,
        ),
      ),
    );
  }
}

class MovieHeader extends StatelessWidget {
  const MovieHeader(this.movie, {super.key});

  final MovieBase movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "${movie.releaseDate} · ${movie.voteAverage}".toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            color: primary,
          ),
        ),
        Text(
          movie.title,
          style: const TextStyle(
              fontSize: 32, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        //const Rating(3),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Text.rich(
            TextSpan(
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w300),
              children: <TextSpan>[
                TextSpan(
                    text: movie.overview,
                    style: const TextStyle(color: Colors.white, fontSize: 14)),
                // const TextSpan(
                //   text: "More...",
                //   style: TextStyle(color: Colors.indigoAccent),
                // ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class Rating extends StatelessWidget {
  final int rating;

  const Rating(this.rating, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: Iterable.generate(
        5,
        (i) => ShaderMask(
          shaderCallback: shader,
          child: Icon(
            i < rating ? Icons.star : Icons.star_border,
            size: 24,
            color: Colors.yellow,
          ),
        ),
      ).toList(),
    );
  }

  ui.Shader shader(Rect rect) => ui.Gradient.linear(
        const Offset(0, 0),
        Offset(0, rect.height),
        [Colors.yellowAccent, Colors.orange],
      );
}

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        height: 0.5,
        color: Colors.white12,
      ),
    );
  }
}

class MoviePeople extends StatelessWidget {
  final MovieBase movie;

  const MoviePeople(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: <Widget>[
          MovieField("Lingua Originale: ", movie.originalLanguage),
        ],
      ),
    );
  }
}

class MovieField extends StatelessWidget {
  final String field;
  final String value;

  const MovieField(this.field, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("$field: ",
              style: const TextStyle(
                  color: Colors.white38,
                  fontSize: 12,
                  fontWeight: FontWeight.w300)),
          Expanded(
              child: Text(
            value,
            style: const TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300),
          ))
        ],
      ),
    );
  }
}

class MovieFeedback extends StatelessWidget {
  MovieBase movie;
  MovieFeedback(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FeedbackButton(Icons.play_arrow, "Guarda", movie),
        ],
      ),
    );
  }
}

class FeedbackButton extends StatelessWidget {
  final IconData icon;
  final String text;
  MovieBase movie;

  FeedbackButton(this.icon, this.text, this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        context.loaderOverlay.show();
        String query = movie.title.replaceAll(" ", "%20");
        query = query.replaceAll("'", "%27");

        final filmResponse = await http.get(
            Uri.parse(
                'https://altadefinizione.navy/index.php?do=search&subaction=search&story=$query&sortby=news_read'),
            headers: {"user-agent": userAgent});

        if (filmResponse.statusCode == 200) {
          var document = parse(filmResponse.body);
          var link = document.getElementsByClassName("titleFilm").first;

          String? filmPageUrl = link.children.first.attributes["href"];
          if (filmPageUrl != null) {
            final channelResponse = await http.get(Uri.parse(filmPageUrl),
                headers: {"user-agent": userAgent});
            if (channelResponse.statusCode == 200) {
              document = parse(channelResponse.body);
              var link = document
                  .getElementsByClassName(
                      "player-container-wrap guardahd-player")
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
                  context.loaderOverlay.hide();
                  showChannelMenu(context, canaliNomi, canaliLink);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "C'è stato un errore nel recuperare i link - Errore: ${videoResponse.statusCode}"),
                  ));
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Non sono stati trovati link"),
                ));
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    "C'è stato un errore nel recuperare il film - Errore: ${channelResponse.statusCode}"),
              ));
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Non è stato trovato il link del film."),
            ));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                "C'è stato un errore nel recuperare il film - Errore: ${filmResponse.statusCode}"),
          ));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                size: 32,
                color: primary,
              ),
            ),
            Text(text, style: const TextStyle(fontSize: 14, color: primary))
          ],
        ),
      ),
    );
  }
}
