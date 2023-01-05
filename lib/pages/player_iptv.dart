// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:yoyo_player/yoyo_player.dart';

class IPTVplayer extends StatefulWidget {
  String urlm3u8 = "";

  IPTVplayer({Key? key, required this.urlm3u8}) : super(key: key);

  @override
  IPTVplayerState createState() => IPTVplayerState();
}

class IPTVplayerState extends State<IPTVplayer> {
  bool fullscreen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          YoYoPlayer(
            aspectRatio: 16 / 9,
            url: widget.urlm3u8,
            videoStyle: VideoStyle(),
            videoLoadingStyle: VideoLoadingStyle(
              loading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Image(
                    image: NetworkImage(
                        'https://media.tenor.com/On7kvXhzml4AAAAj/loading-gif.gif'),
                    fit: BoxFit.fitHeight,
                    height: 50,
                  ),
                  Text("Caricamento..."),
                ],
              ),
            ),
            onFullScreen: (t) {
              setState(() {
                fullscreen = t;
              });
            },
          ),
        ],
      ),
    );
  }
}
