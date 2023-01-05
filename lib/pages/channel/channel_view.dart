// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tv/commons/vars.dart';
import 'package:flutter_tv/model/channel_model.dart';
import 'package:flutter_tv/widget/channel_card.dart';
import 'package:m3u/m3u.dart';

class ChannelView extends StatefulWidget {
  String linktom3u;
  ChannelView({super.key, required this.linktom3u});

  @override
  State<ChannelView> createState() => _ChannelViewState();
}

class _ChannelViewState extends State<ChannelView> {
  late List<ChannelModel> channelList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getChannel();
  }

  getChannel() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(Uri.parse(widget.linktom3u));
    final m3u = await M3uParser.parse(response.body);

    for (final entry in m3u) {
      if (entry.link != "" && entry.title != "") {
        setState(() {
          channelList.add(ChannelModel(link: entry.link, nome: entry.title));
        });
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff202020),
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: primary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        leading: const BackButton(),
      ),
      body: isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  GridView.builder(
                    itemCount: channelList.length,
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const ClampingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.68,
                    ),
                    itemBuilder: (context, index) {
                      return ChannelCard(channel: channelList[index]);
                    },
                  )
                ],
              ),
            ),
    );
  }
}
