import 'package:flutter/material.dart';
import 'package:quizzlette/Screens/home_screen.dart';
import 'package:quizzlette/Screens/intro_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Roboto'),
        home: IntroScreen());
  }
}
