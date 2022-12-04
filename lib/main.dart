import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_tv/pages/home_page.dart';


void main(List<String> args) {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MaterialApp(
    home:  const HomePage(),
    title: "Flutter TV",
    theme: ThemeData(
      primarySwatch: Colors.green,
    ),
  ));
  
}
