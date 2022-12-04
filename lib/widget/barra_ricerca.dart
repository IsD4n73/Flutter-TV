import 'package:flutter/material.dart';
import 'package:flutter_tv/commons/vars.dart';

Widget barraRIcerca(TextEditingController textController) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Material(
      elevation: 5.0,
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: TextField(
        controller: textController,
        cursorColor: primary,
        style: dropdownMenuItem,
        decoration: const InputDecoration(
            hintText: "Cerca",
            hintStyle: TextStyle(color: Colors.black38, fontSize: 16),
            prefixIcon: Material(
              elevation: 0.0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Icon(Icons.search),
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
      ),
    ),
  );
}
