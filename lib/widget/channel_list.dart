import 'package:flutter/material.dart';
import 'package:flutter_tv/commons/vars.dart';
import 'package:flutter_tv/controller/web_loader.dart';

showChannelMenu(
    BuildContext parentContext, List<String> canali, List<String?> links) {
  showModalBottomSheet(
      context: parentContext,
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
                          child: ListView.builder(
                            itemCount: canali.length,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (contextChild, index) {
                              return ListTile(
                                title: Text(
                                  canali[index].trim(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                leading: const Icon(
                                  Icons.mail_outline,
                                  color: Colors.white,
                                ),
                                onTap: () async {
                                  if (links[index] != null) {
                                    List<String> names =
                                        await getEntriesFrom("${links[index]}");
                                    /*Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => VideoPlayerWidget(
                                            link: "https:${links[index]!}"),
                                      ),
                                    );*/
                                    //todo: link to player
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Questo link non è disponibile."),
                                      ),
                                    );
                                  }
                                },
                              );
                            },
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
