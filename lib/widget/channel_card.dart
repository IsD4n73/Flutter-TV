// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_tv/model/channel_model.dart';
import 'package:flutter_tv/pages/video_player.dart';

class ChannelCard extends StatefulWidget {
  ChannelModel channel;

  ChannelCard({super.key, required this.channel});

  @override
  State<ChannelCard> createState() => _ChannelCardState();
}

class _ChannelCardState extends State<ChannelCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayerWidget(
              link: widget.channel.link,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(4),
        color: const Color(0xffffffff),
        shadowColor: const Color(0xff000000),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image(
                image: NetworkImage(widget.channel.image),
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.channel.nome,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                          color: Color(0xff000000),
                        ),
                      ),
                      /*Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(0),
                              padding: const EdgeInsets.all(0),
                              width: 40,
                              height: 20,
                              decoration: BoxDecoration(
                                color: primary,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.zero,
                                border: Border.all(
                                    color: const Color(0x4d9e9e9e), width: 1),
                              ),
                              child: const Text(
                                "50%",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 11,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),*/
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
