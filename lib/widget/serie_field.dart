import 'package:flutter/material.dart';
import 'package:flutter_tv/pages/serie/serie_details.dart';
import 'package:tmdb_dart/tmdb_dart.dart';

import '../commons/vars.dart';

class BuildSerie extends StatelessWidget {
  final int index;
  final List<TvBase> channelList;
  const BuildSerie({Key? key, required this.index, required this.channelList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListTile(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        onTap: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SeriePage(channelList[index]),
            ),
          );
        },
        leading: Container(
          width: 60,
          height: 60,
          margin: const EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            border: Border.all(width: 3, color: secondary),
            image: DecorationImage(
                image: NetworkImage(channelList[index].posterPath!),
                fit: BoxFit.fill),
          ),
        ),
        tileColor: Colors.white,
        title: Text(
          channelList[index].name,
          style: const TextStyle(
              color: primary, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: RichText(
          text: TextSpan(
            children: [
              const WidgetSpan(
                child: Icon(
                  Icons.tag,
                  size: 14,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: " ${channelList[index].firstAirDate}",
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
