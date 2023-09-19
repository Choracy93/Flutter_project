import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';

class HumidityScreen extends StatefulWidget {
  final Weather weather;

  HumidityScreen({required this.weather});

  @override
  State<HumidityScreen> createState() => _HumidityScreenState();
}

class _HumidityScreenState extends State<HumidityScreen> {
  int _getHumidityColor(double humidity) {
    final humidityValue = humidity.round();

    if (humidityValue < 10) {
      return Colors.red.value;
    } else if (humidityValue < 25) {
      return Colors.orange.value;
    } else if (humidityValue < 40) {
      return Colors.green.value;
    } else if (humidityValue < 60) {
      return Colors.blue.value;
    } else {
      return Colors.lightBlue.value;
    }
  }

  String _getHumidityDescription(double humidity) {
    final humidityValue = humidity.round();

    if (humidityValue < 10) {
      return "Bardzo niski";
    } else if (humidityValue < 25) {
      return "Niski";
    } else if (humidityValue < 40) {
      return "Przeciętny";
    } else if (humidityValue < 60) {
      return "Wysoki";
    } else {
      return "Bardzo wysoki";
    }
  }

  @override
  Widget build(BuildContext context) {
    final humidity = widget.weather.humidity ?? 0.0;
    final backgroundColor = Color(_getHumidityColor(humidity));
    final humidityDescription = _getHumidityDescription(humidity);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              gradient: getGradientByMood(),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Poziom wilgotności",
                  style: GoogleFonts.lora(
                    textStyle: TextStyle(
                      fontSize: 25.0,
                      height: 1.2,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 5)),
                SizedBox(height: 10),
                Text(
                  "${humidity.toStringAsFixed(0)}%",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lora(
                    textStyle: TextStyle(
                      fontSize: 40.0,
                      height: 1.2,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 5)),
                SizedBox(height: 10),
                Text(
                  humidityDescription,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lora(
                    textStyle: TextStyle(
                      fontSize: 22.0,
                      height: 1.2,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Icon(
                  Icons.water_drop,
                  color: Colors.black,
                  size: 150,
                ),
                SizedBox(height: 20),
                Text(
                  widget.weather.areaName ?? "Brak danych",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lora(
                    textStyle: TextStyle(
                      fontSize: 25.0,
                      height: 1.2,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  LinearGradient getGradientByMood() {
    final backgroundColor = Color(_getHumidityColor(widget.weather.humidity ?? 0.0));

    if (backgroundColor == Colors.red) {
      return LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color(0xffFF3333),
          Color(0xffFF0033),
          Color(0xffCC0000),
        ],
      );
    } else if (backgroundColor == Colors.orange) {
      return LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color(0xffFF9966),
          Color(0xffFF9933),
          Color(0xffFF9900),
        ],
      );
    } else if (backgroundColor == Colors.green) {
      return LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color(0xff33CC66),
          Color(0xff99FF99),
          Color(0xff99FFCC),
        ],
      );
    } else if (backgroundColor == Colors.blue) {
      return LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color(0xff33CCFF),
          Color(0xff3399FF),
          Color(0xff9999FF),
        ],
      );
    } else {
      return LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color(0xff9999FF),
          Color(0xff9999CC),
          Color(0xff99CCCC),
        ],
      );
    }
  }
}
