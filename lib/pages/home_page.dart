import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_tv/commons/vars.dart';
import 'package:flutter_tv/controller/provider/guardaserie.dart';
import 'package:flutter_tv/pages/film/film_search.dart';
import 'package:flutter_tv/pages/film/film_view.dart';
import 'package:flutter_tv/pages/serie/serie_search.dart';
import 'package:flutter_tv/pages/serie/series_view.dart';
import 'package:flutter_tv/pages/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: primary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            if (_bottomNavIndex == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CercaFilm(),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CercaSerie(),
                ),
              );
            }
          },
          icon: const Icon(
            Icons.search,
          ),
        ),
        title: const Text(
          "Flutter TV",
          style: TextStyle(color: Colors.white),
        ),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: const [Icons.movie, Icons.tv],
        activeColor: primary,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SettingsPage(),
            ),
          );
        },
        backgroundColor: primary,
        child: const Icon(Icons.settings),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _bottomNavIndex == 0 ? const FilmPopolari() : const SeriePopolari(),
    );
  }
}
