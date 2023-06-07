import 'dart:ui' as ui;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tv/commons/vars.dart';
import 'package:flutter_tv/controller/get_episode.dart';
import 'package:flutter_tv/controller/provider/guardaserie.dart';
import 'package:flutter_tv/model/episodio_model.dart';
import 'package:flutter_tv/model/season_model.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:tmdb_dart/tmdb_dart.dart';

class SeriePage extends StatefulWidget {
  final TvBase movie;
  const SeriePage(this.movie, {super.key});

  @override
  State<SeriePage> createState() => _SeriePageState();
}

class _SeriePageState extends State<SeriePage> {
  late SeasonModel model;
  late List<String> stagioni = [];
  late List<EpisodioModel> episodi = [];
  String? selectedSeason;

  @override
  void initState() {
    super.initState();
    fetchEpisode(widget.movie.id).then((value) {
      setState(() {
        model = value;
        stagioni = List<String>.generate(
            value.number_of_seasons, (index) => "Stagione ${index + 1}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: LoaderOverlay(
        overlayColor: Colors.black,
        overlayOpacity: 0.8,
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: ListView(
            children: <Widget>[
              MovieThumbnail(widget.movie.backdropPath),
              MovieHeaderWithPoster(widget.movie),
              const HorizontalLine(),
              MoviePeople(widget.movie),
              Padding(
                padding: const EdgeInsets.all(8),
                child: DropdownButton2(
                  hint: const Text(
                    'Seleziona Stagione',
                    style: TextStyle(color: Colors.white),
                  ),
                  dropdownStyleData: const DropdownStyleData(
                    decoration: BoxDecoration(
                      color: bgColor,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  items: stagioni
                      .map(
                        (item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  value: selectedSeason,
                  onChanged: (value) async {
                    setState(() {
                      selectedSeason = value;
                    });

                    fetchListEpisode(widget.movie.id, value).then((value) {
                      setState(() {
                        episodi = value;
                      });
                    });
                  },
                ),
              ),
              SerieEpisodes(widget.movie.id, episodi, widget.movie,
                  selectedSeason?.split(" ").last ?? "0"),
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
              child: Image.network(thumbnail ?? noImg),
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
  final TvBase movie;
  const MovieHeaderWithPoster(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          MoviePoster(movie.posterPath ?? noImg),
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

  final TvBase movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "${movie.firstAirDate} · ${movie.voteAverage}".toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            color: primary,
          ),
        ),
        Text(
          movie.name,
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
  final TvBase movie;

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
  const MovieFeedback({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FeedbackButton(Icons.play_arrow, "Guarda"),
        ],
      ),
    );
  }
}

class FeedbackButton extends StatelessWidget {
  final IconData icon;
  final String text;

  const FeedbackButton(this.icon, this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //showChannelMenu(context);
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

// ignore: must_be_immutable
class SerieEpisodes extends StatefulWidget {
  int id;
  String season;
  TvBase tvInfo;
  List<EpisodioModel> stagioneSelezionata;
  SerieEpisodes(this.id, this.stagioneSelezionata, this.tvInfo, this.season,
      {super.key});

  @override
  State<SerieEpisodes> createState() => _SerieEpisodesState();
}

class _SerieEpisodesState extends State<SerieEpisodes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
      padding: const EdgeInsets.all(0),
      width: MediaQuery.of(context).size.width,
      height: 180,
      decoration: const BoxDecoration(
        color: Color(0x00ffffff),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.zero,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(5),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: widget.stagioneSelezionata.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
            child: InkWell(
              onTap: () async {
                await guardaserieProvider(
                    context,
                    widget.tvInfo,
                    widget.stagioneSelezionata[index].episode_number,
                    widget.season);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image(
                    image:
                        NetworkImage(widget.stagioneSelezionata[index].poster),
                    height: 140,
                    width: 140,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 140,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: TextScroll(
                        "Episodio ${widget.stagioneSelezionata[index].episode_number} - ${widget.stagioneSelezionata[index].name}           ",
                        textAlign: TextAlign.start,
                        velocity:
                            const Velocity(pixelsPerSecond: Offset(20, 0)),
                        //mode: TextScrollMode.endless,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 11,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/*
ListView(

        children: [

        ],
      ),


*/
