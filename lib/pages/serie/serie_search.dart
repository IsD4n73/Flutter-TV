import 'package:flutter/material.dart';
import 'package:flutter_tv/commons/vars.dart';
import 'package:flutter_tv/controller/tmdb.dart';
import 'package:flutter_tv/pages/serie/serie_details.dart';
import 'package:text_scroll/text_scroll.dart';

class CercaSerie extends StatefulWidget {
  const CercaSerie({Key? key}) : super(key: key);

  @override
  CercaSerieState createState() => CercaSerieState();
}

class CercaSerieState extends State<CercaSerie> {
  TextEditingController ricerca = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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
                  await cercaSerieVal(value);
                  setState(() {
                    serieCercati = List.of(MoviePopular.serieResult);
                  });
                }
              },
              decoration: const InputDecoration(
                hintText: "Cerca Serie TV",
                hintStyle: TextStyle(color: Colors.black38, fontSize: 16),
                prefixIcon: Material(
                  elevation: 0.0,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: Icon(Icons.search),
                ),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 25, vertical: 13),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: serieCercati.length,
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
                                SeriePage(serieCercati[index])),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: NetworkImage(
                              serieCercati[index].posterPath ?? noImg),
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
                                  "${serieCercati[index].name}      ",
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
                      ),
                    ),
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
