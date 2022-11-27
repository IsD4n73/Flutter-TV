import 'package:flutter/material.dart';
import 'package:flutter_tv/pages/home_page.dart';


void main(List<String> args) {
  runApp(MaterialApp(
    home: const HomePage(),
    theme: ThemeData(
      primarySwatch: Colors.green,
    ),
  ));
  
}
