import 'package:flutter/material.dart';
import 'package:flutter_tv/commons/vars.dart';
import 'package:yoyo_player/yoyo_player.dart';

class IPTVplayer extends StatefulWidget {
  const IPTVplayer({Key? key}) : super(key: key);

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
            url: urlM3u8,
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
