import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'PermissionScreen.dart';

import 'MyHomePage.dart';
import 'SplashScreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appTitle,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),//SplashScreen
    );
  }
}

class Strings {
  static const String appTitle = 'Aplikacja pogodowa';
}

