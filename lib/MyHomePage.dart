import 'package:flutter/material.dart';
import 'SplashScreen.dart';
import 'package:weather/weather.dart';
import 'HpaScreen.dart';
import 'HumidityScreen.dart';
import 'AirQualityScreen.dart';

import 'WeatherScreen.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.weather, required this.air});

  final Weather weather;
  final AirPurity air;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _currentIndex = 0;
  var screens;


  @override
  void initState() {
    screens = [
      AirQualityScreen(air: widget.air),
      WeatherScreen(weather: widget.weather),
      HumidityScreen(weather: widget.weather),
      HpaScreen(weather: widget.weather),
    ];
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black38,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 35,
        currentIndex: _currentIndex,
        onTap: (index) => setState(()=>_currentIndex = index),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.masks_outlined),
              label: "Powietrze"),
          BottomNavigationBarItem(
              icon: Icon(Icons.wb_cloudy_outlined),
              label: "Pogoda"),
          BottomNavigationBarItem(
              icon: Icon(Icons.water_drop_outlined),
              label: "Wilgotność"),
          BottomNavigationBarItem(
              icon: Icon(Icons.ad_units_sharp),
              label: "Ciśnienie"),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
