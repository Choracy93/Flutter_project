import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';

class HpaScreen extends StatefulWidget {
  final Weather weather;

  HpaScreen({required this.weather});

  @override
  State<HpaScreen> createState() => _HpaScreenState();
}

class _HpaScreenState extends State<HpaScreen> {
  int _getPressureColor(double pressure) {
    if (pressure < 1010) {
      return Colors.blue.value;
    } else if (pressure >= 1010 && pressure < 1015) {
      return Colors.green.value;
    } else {
      return Colors.red.value;
    }
  }

  String _getPressureDescription(double pressure) {
    if (pressure < 1010) {
      return "Ciśnienie obniżone";
    } else if (pressure >= 1010 && pressure < 1015) {
      return "Ciśnienie w normie";
    } else {
      return "Ciśnienie podwyższone";
    }
  }

  @override
  Widget build(BuildContext context) {
    final pressure = widget.weather.pressure ?? 0.0;
    final backgroundColor = Color(_getPressureColor(pressure));
    final pressureDescription = _getPressureDescription(pressure);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              gradient: getGradientByPressure(pressure),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Poziom ciśnienia",
                  style: GoogleFonts.lora(
                    textStyle: TextStyle(
                      fontSize: 25.0,
                      height: 1.2,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${pressure.toStringAsFixed(0)} \n hPa",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lora(
                          textStyle: TextStyle(
                            fontSize: 30.0,
                            height: 1.2,
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  pressureDescription,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lora(
                    textStyle: TextStyle(
                      fontSize: 20.0,
                      height: 1.2,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Image(
                  image: AssetImage('icons/pressure.png'), //https://icons8.com/icons/set/sun
                  width: 150,
                  height: 150,
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

  LinearGradient getGradientByPressure(double pressure) {
    if (pressure < 1010) {
      return LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [
          Colors.lightBlue,
          Colors.blue,
        ],
      );
    } else if (pressure >= 1010 && pressure < 1015) {
      return LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [
          Colors.lightGreen,
          Colors.green,
        ],
      );
    } else {
      return LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [
          Colors.redAccent,
          Colors.red,
        ],
      );
    }
  }
}
