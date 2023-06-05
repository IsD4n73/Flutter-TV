import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tv/commons/vars.dart';
import 'package:flutter_tv/pages/home_page.dart';
import 'package:upgrader/upgrader.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cfg = AppcastConfiguration(url: appcastURL, supportedOS: ['android']);
    return MaterialApp(
      home: UpgradeAlert(
        upgrader: Upgrader(
          countryCode: "it",
          languageCode: "it",
          appcastConfig: cfg,
          durationUntilAlertAgain: const Duration(seconds: 5),
          messages: UpgraderMessages(code: 'it'),
          showIgnore: false,
        ),
        child: const HomePage(),
      ),
      title: "Flutter TV",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
