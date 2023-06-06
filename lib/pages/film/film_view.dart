import 'package:flutter/material.dart';
import 'package:flutter_tv/commons/vars.dart';
import 'package:flutter_tv/controller/tmdb.dart';
import 'package:flutter_tv/widget/film_field.dart';
import 'package:loader_overlay/loader_overlay.dart';

class FilmPopolari extends StatefulWidget {
  const FilmPopolari({Key? key}) : super(key: key);

  @override
  FilmPopolariState createState() => FilmPopolariState();
}

class FilmPopolariState extends State<FilmPopolari> {
  int pagina = 1;
  TextEditingController ricerca = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await tmdbFilm();
      setState(() {
        filmPopolari = List.of(MoviePopular.movieResult);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      overlayColor: Colors.black,
      overlayOpacity: 0.8,
      child: SingleChildScrollView(
        child: ListView.builder(
          itemCount: filmPopolari.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            if (index == filmPopolari.length - 1) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primary),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    context.loaderOverlay.show();
                    pagina = pagina + 1;
                    await tmdbFilmPage(pagina);
                    setState(() {
                      filmPopolari.addAll(MoviePopular.movieResult);
                    });
                    await Future.delayed(const Duration(seconds: 2));
                    context.loaderOverlay.hide();
                  },
                  child: const Text(
                    "Carica Altro",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            } else {
              return BuildMovie(
                index: index,
                channelList: filmPopolari,
              );
            }
          },
        ),
      ),
    );
  }
}
