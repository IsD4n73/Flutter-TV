import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_tv/commons/vars.dart';
import 'package:flutter_tv/pages/home_page.dart';
import 'package:upgrader/upgrader.dart';

void main(List<String> args) {
  final cfg = AppcastConfiguration(url: appcastURL, supportedOS: ['android']);

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(MaterialApp(
    home: UpgradeAlert(
      upgrader: Upgrader(
          countryCode: "it",
          languageCode: "it",
          appcastConfig: cfg,
          durationUntilAlertAgain: const Duration(seconds: 5),
          messages: UpgraderMessages(code: 'it'),
          showIgnore: false),
      child: const HomePage(),
    ),
    title: "Flutter TV",
    theme: ThemeData(
      primarySwatch: Colors.green,
    ),
  ));
}
