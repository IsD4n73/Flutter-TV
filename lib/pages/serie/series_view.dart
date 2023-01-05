import 'package:flutter/material.dart';
import 'package:flutter_tv/commons/vars.dart';
import 'package:flutter_tv/controller/tmdb.dart';
import 'package:flutter_tv/pages/serie/serie_search.dart';
import 'package:flutter_tv/widget/serie_field.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SeriePopolari extends StatefulWidget {
  const SeriePopolari({Key? key}) : super(key: key);

  @override
  SeriePopolariState createState() => SeriePopolariState();
}

class SeriePopolariState extends State<SeriePopolari> {
  int pagina = 1;

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
                      padding: const EdgeInsets.only(top: 100),
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: ListView.builder(
                          itemCount: seriePopolari.length,
                          itemBuilder: (BuildContext context, int index) {
                            return buildSerie(context, index, seriePopolari);
                          }),
                    ),
                    Container(
                      height: 100,
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const CercaSerie()),
                                );
                              },
                              icon: const Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                            ),
                            const Text(
                              "Flutter TV",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
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
                      ))
                ]),
          ],
        ),
      ),
    );
  }
}
