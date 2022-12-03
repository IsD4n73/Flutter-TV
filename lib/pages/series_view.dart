import 'package:flutter/material.dart';
import 'package:flutter_tv/commons/vars.dart';
import 'package:flutter_tv/controller/tmdb.dart';
import 'package:flutter_tv/widget/serie_field.dart';

class SeriePopolari extends StatefulWidget {
  const SeriePopolari({Key? key}) : super(key: key);

  @override
  SeriePopolariState createState() => SeriePopolariState();
}

class SeriePopolariState extends State<SeriePopolari> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await tmdbSerie();
      setState(() {
        seriePopolari = MoviePopular.serieResult;
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
                    itemCount: seriePopolari.length,
                    itemBuilder: (BuildContext context, int index) {
                      return buildSerie(context, index, seriePopolari);
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
