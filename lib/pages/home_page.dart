// ignore_for_file: sized_box_for_whitespace

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tv/commons/vars.dart';
import 'package:flutter_tv/controller/get_channel.dart';
import 'package:flutter_tv/widget/channel_list.dart';
import '../widget/home_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> channels = [];
  late String jsontxt;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await getChannels().then((value) => jsontxt = value);
      setState(() {
        channels = (json.decode(jsontxt) as List).cast();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff202020),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 100),
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: channels.length,
                    itemBuilder: (BuildContext context, int index) {
                      return buildList(context, index, channels);
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
                          //tmdb();
                          
                        },
                        icon: const Icon(
                          Icons.info,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "Flutter TV",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
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
