import 'package:flutter/material.dart';
import 'package:flutter_tv/commons/vars.dart';
import 'package:flutter_tv/controller/tmdb.dart';
import 'package:flutter_tv/widget/serie_field.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tmdb_dart/tmdb_dart.dart';

class SeriePopolari extends StatefulWidget {
  const SeriePopolari({Key? key}) : super(key: key);

  @override
  SeriePopolariState createState() => SeriePopolariState();
}

class SeriePopolariState extends State<SeriePopolari> {
  int pagina = 1;
  List<TvBase> seriePopolari = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await tmdbSerie();
      setState(() {
        seriePopolari = List.of(MoviePopular.serieResult);
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
          itemCount: seriePopolari.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            if (index == seriePopolari.length - 1) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(primary),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                  onPressed: () async {
                    context.loaderOverlay.show();

                    pagina = pagina + 1;

                    await tmdbSeriePage(pagina);
                    setState(() {
                      seriePopolari.addAll(MoviePopular.serieResult);
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
              return BuildSerie(
                index: index,
                channelList: seriePopolari,
              );
            }
          },
        ),
      ),
    );
  }
}
