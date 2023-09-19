import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';
import 'package:http/http.dart' as http;
import 'MyHomePage.dart';
import 'PermissionScreen.dart';
import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Weather? _weather;
  AirPurity? _air;

  @override
  Widget build(BuildContext context) {
    if (_weather != null && _air != null) {
      return MyHomePage(weather: _weather!, air: _air!);
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: new Color(0xffffffff),
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [new Color(0xff00BFFF), new Color(0xff5F9EA0)],
              ),
            ),
          ),
          Align(
            alignment: FractionalOffset.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('icons/slonce.png'),
                ),
                Padding(padding: EdgeInsets.only(top: 15.0)),
                Text(Strings.appTitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lora(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 38.0,
                            color: Colors.black))),
                Padding(padding: EdgeInsets.only(top: 5.0)),
                Text('Aplikacja do sprawdzania pogody, wilgotności, '
                    'jakości powietrza i ciśnienia',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lora(
                        textStyle:
                        TextStyle(fontSize: 16.0, color: Colors.black))),
              ],
            ),
          ),
          Positioned(
            left: 0,
            bottom: 45,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              child: Text("Sprawdzanie informacji...",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lora(
                      textStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                          color: Colors.black))),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => PermissionScreen()));
    } else {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        fetchWeatherAndAirData();
      });
    }
  }

  void fetchWeatherAndAirData() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    WeatherFactory wf = WeatherFactory(
      "f85127cfec80065339b1e63bcee1dad3",
      language: Language.POLISH,
    );
    Weather w = await wf.currentWeatherByLocation(
      position.latitude,
      position.longitude,
    );

    var lat = position.latitude;
    var lon = position.longitude;
    var keyword = 'geo:$lat;$lon';
    var key = 'e59bd0a6caf179e343e16daee45a98f046757202';
    String _endpoint = 'https://api.waqi.info/feed/';
    String url = '$_endpoint/$keyword/?token=$key';

    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> jsonBody = json.decode(response.body);
    AirPurity ap = AirPurity(jsonBody);

    setState(() {
      _weather = w;
      _air = ap;
    });
  }
}

class AirPurity {
  bool isGood = false;
  bool isNormal = false;
  bool isNeutral = false;
  bool isBad = false;
  String quality = "";
  int aqi = 0;
  int pm2_5 = 0;
  int pm10 = 0;
  String station = "";

  AirPurity(Map<String, dynamic> jsonBody) {
    aqi = int.tryParse(jsonBody['data']['aqi'].toString()) ?? -1;
    pm2_5 = int.tryParse(jsonBody['data']['iaqi']['pm25']['v'].toString()) ?? -1;
    pm10 = int.tryParse(jsonBody['data']['iaqi']['pm10']['v'].toString()) ?? -1;
    station = jsonBody['data']['city']['name'].toString();
    setupLevel(aqi);
  }

  void setupLevel(int aqi) {
    if (aqi <= 75) {
      quality = "Wysoka";
      isGood = true;
    } else if (aqi <= 100) {
      quality = "Dobra";
      isNormal = true;
    } else if (aqi <= 125) {
      quality = "Średnia";
      isNeutral = true;
    } else if (aqi <= 150) {
      quality = "Słaba";
      isBad = false;
    } else {
      quality = "Zła";
    }
  }
}


//Chojnacki Miłosz
//Adrian Kozłowski