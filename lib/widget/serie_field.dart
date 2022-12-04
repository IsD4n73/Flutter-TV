import 'package:flutter/material.dart';
import 'package:flutter_tv/pages/film_details.dart';
import 'package:flutter_tv/pages/serie_details.dart';

import '../commons/vars.dart';

Widget buildSerie(BuildContext context, int index, var channelList) {
  return InkWell(
      onTap: () async {
              Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SeriePage(channelList[index])),
        );
      },
      borderRadius: BorderRadius.circular(25),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        width: double.infinity,
        height: 150,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 70,
              height: 70,
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 3, color: secondary),
                image: DecorationImage(
                    image: NetworkImage(channelList[index].posterPath ?? "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg?20200913095930"),
                    fit: BoxFit.fill),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    channelList[index].name,
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
                      Text("${channelList[index].firstAirDate}",
                          style: const TextStyle(
                              color: primary, fontSize: 13, letterSpacing: .3)),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                ],
              ),
            ),
          ],
        ),
      ));
}
