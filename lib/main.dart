// @dart=2.9
import 'package:flutter/material.dart';
import 'package:wallpaper_app/wallpaper.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      title: "Wallpaper App",
      home: const Wallpaper(),
    );
  }
}