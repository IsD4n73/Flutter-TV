import 'package:flutter/material.dart';
import 'package:flutter_tv/commons/vars.dart';
import 'package:flutter_tv/model/channel_model.dart';

showChannelMenu(BuildContext context) {
  List<String> ls = List<String>.generate(10, (i) => 'Canale $i');

  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              height: 36,
            ),
            SizedBox(
                height: (56 * 6).toDouble(),
                child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                      color: bgColor,
                    ),
                    child: Stack(
                      alignment: const Alignment(0, 0),
                      children: <Widget>[
                        Positioned(
                          child: Expanded(
                            child: ListView.builder(
                              itemCount: ls.length,
                              physics: const ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  ls[index],
                                  style: const TextStyle(color: Colors.white),
                                ),
                                leading: const Icon(
                                  Icons.mail_outline,
                                  color: Colors.white,
                                ),
                                onTap: () {},
                              );
                            },
                          )

                              // ListView(
                              //   physics: const ClampingScrollPhysics(),
                              //   children: <Widget>[

                              //   ],
                              // ),
                              ),
                        )
                      ],
                    ))),
          ],
        );
      });
}



/*


 ListTile(
                                  title: const Text(
                                    "Drafts",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  leading: const Icon(
                                    Icons.mail_outline,
                                    color: Colors.white,
                                  ),
                                  onTap: () {},
                                ),



                                */