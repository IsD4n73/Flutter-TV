import 'package:flutter/material.dart';
import 'package:flutter_tv/commons/vars.dart';
import 'package:flutter_tv/controller/tmdb.dart';
import 'package:flutter_tv/widget/film_field.dart';
import 'package:flutter_tv/widget/home_field.dart';
import 'package:loader_overlay/loader_overlay.dart';

class FilmPopolari extends StatefulWidget {
  const FilmPopolari({Key? key}) : super(key: key);

  @override
  FilmPopolariState createState() => FilmPopolariState();
}

class FilmPopolariState extends State<FilmPopolari> {
  int pagina = 1;

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
      child: Scaffold(
        backgroundColor: const Color(0xff202020),
        body: Column(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 50,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 145),
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: ListView.builder(
                          itemCount: filmPopolari.length,
                          itemBuilder: (BuildContext context, int index) {
                            return buildMovie(context, index, filmPopolari);
                          }),
                    ),
                    Container(
                      height: 110,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.info,
                                color: Colors.white,
                              ),
                            ),
                            const Text(
                              "Flutter TV",
                              style: TextStyle(color: Colors.white, fontSize: 24),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(primary),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      onPressed: () async {
                        context.loaderOverlay.show();
                        pagina = pagina + 1;
                        print("---------- $pagina");
    
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
                      ))
                ]),
          ],
        ),
      ),
    );
  }
}
