import 'package:flutter/material.dart';
import 'package:flutter_tv/pages/film/film_details.dart';

import '../commons/vars.dart';

class BuildMovie extends StatelessWidget {
  final int index;
  final List<dynamic> channelList;
  const BuildMovie({Key? key, required this.index, required this.channelList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MoviePage(channelList[index]),
          ),
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
                    image: NetworkImage(channelList[index].posterPath),
                    fit: BoxFit.fill),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    channelList[index].title,
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
                      Text(
                        "${channelList[index].releaseDate}",
                        style: const TextStyle(
                            color: primary, fontSize: 13, letterSpacing: 3),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
