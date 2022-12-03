import 'package:flutter/material.dart';
import 'package:flutter_tv/commons/vars.dart';
import 'package:flutter_tv/controller/tmdb.dart';
import 'package:flutter_tv/widget/film_field.dart';
import 'package:flutter_tv/widget/home_field.dart';

class FilmPopolari extends StatefulWidget {
  const FilmPopolari({Key? key}) : super(key: key);

  @override
  FilmPopolariState createState() => FilmPopolariState();
}

class FilmPopolariState extends State<FilmPopolari> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await tmdbFilm();
      setState(() {
        filmPopolari = MoviePopular.movieResult;
      });
    });
    

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff202020),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
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
    );
  }
}
