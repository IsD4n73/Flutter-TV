import 'package:flutter/material.dart';

import '../commons/vars.dart';

Widget buildList(BuildContext context, int index) {
  return InkWell(
      onTap: () {
        String url = channelList[index]['nome'];
        if (url.endsWith(".m3u8") || url.endsWith("m3u")) {
          print("Apri lista");
        } else if (url == "page") {
          print("Apertura pagina");
        } else {
          print("apri link");
        }
      },
      borderRadius: BorderRadius.circular(25),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        width: double.infinity,
        height: 110,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    channelList[index]['nome'],
                    style: const TextStyle(
                        color: primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.tag,
                        color: secondary,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(channelList[index]['categorie'],
                          style: const TextStyle(
                              color: primary, fontSize: 13, letterSpacing: .3)),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                ],
              ),
            )
          ],
        ),
      ));
}
