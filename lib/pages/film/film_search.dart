import 'package:flutter/material.dart';
import 'package:flutter_tv/commons/vars.dart';
import 'package:flutter_tv/controller/tmdb.dart';
import 'package:flutter_tv/pages/film/film_details.dart';
import 'package:text_scroll/text_scroll.dart';

class CercaFilm extends StatefulWidget {
  const CercaFilm({Key? key}) : super(key: key);

  @override
  CercaFilmState createState() => CercaFilmState();
}

class CercaFilmState extends State<CercaFilm> {
  TextEditingController ricerca = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          const SizedBox(height: 50),
          Material(
            elevation: 5.0,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: TextField(
              controller: ricerca,
              cursorColor: primary,
              style: dropdownMenuItem,
              onChanged: (value) async {
                if (value.isNotEmpty) {
                  await cercaFilmVal(value);
                  setState(() {
                    filmCercati = List.of(MoviePopular.movieResult);
                  });
                }
              },
              decoration: const InputDecoration(
                  hintText: "Cerca Film",
                  hintStyle: TextStyle(color: Colors.black38, fontSize: 16),
                  prefixIcon: Material(
                    elevation: 0.0,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: Icon(Icons.search),
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: filmCercati.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MoviePage(filmCercati[index])),
                      );
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: NetworkImage(
                                filmCercati[index].posterPath ?? noImg),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          color: Colors.black.withOpacity(0.5),
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: TextScroll(
                                    "${filmCercati[index].title}      ",
                                    textAlign: TextAlign.center,
                                    velocity: const Velocity(
                                        pixelsPerSecond: Offset(50, 0)),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
