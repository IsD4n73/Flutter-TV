import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/material.dart';

Future<List<String>> getEntriesFrom(String url) async {
  List<String> entries = [];
  String javaScript = '''
  function getResource(){
    var resource = window.performance.getEntries();
    var names = [];
  
    resource.forEach(function(x) {
        names.push(x.name);
    });
  
    return names;
  }
  getResource();
  ''';

  InAppWebViewController? controller;

  InAppWebView(
    initialUrlRequest: URLRequest(
      url: Uri.parse(url),
    ),
    onWebViewCreated: (cont) {
      controller = cont;
    },
    onProgressChanged: (_, progress) => print("PROGRESS: $progress"),
    onLoadStop: (controller, url) async {
      var names = await controller.evaluateJavascript(source: javaScript);

      print(names);
    },
  );

  await controller?.loadUrl(
    urlRequest: URLRequest(
      url: Uri.parse(url),
    ),
  );

  var x = await controller?.evaluateJavascript(
      source: "window.performance.getEntries();");

  print(x);

  return entries;
}
