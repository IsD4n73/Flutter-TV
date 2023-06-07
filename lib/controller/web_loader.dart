import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

Future<List<String>> getEntriesFrom(String url) async {
  List<String> entries = [];

  print("URL: $url");

  String javaScript = '''var resource = window.performance.getEntries();
  
    resource.forEach(function(x) {
        console.log(x.name);
    });
  ''';

  HeadlessInAppWebView headlessWebView = HeadlessInAppWebView(
    initialUrlRequest: URLRequest(url: Uri.parse(url)),
    onProgressChanged: (controller, progress) =>
        BotToast.showText(text: "$progress%", onlyOne: false),
    onConsoleMessage: (controller, consoleMessage) {
      print(consoleMessage.message);
    },
    onLoadStop: (controller, url) async {
      print("Caricato $url");
      controller.evaluateJavascript(source: javaScript);
    },
  );

  await headlessWebView.run();

  await headlessWebView.webViewController
      .evaluateJavascript(source: javaScript);

  headlessWebView.dispose();
  return entries;
}
