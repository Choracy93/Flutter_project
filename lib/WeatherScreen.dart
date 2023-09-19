import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key, required this.weather});
  final Weather weather;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffffffff),
              gradient: getGradientByMood(widget.weather),
            ),
          ),
          Align(
            alignment: FractionalOffset.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 40.0)),
                Image(
                  image: AssetImage('icons/${iconWeather(widget.weather)}.png'),
                  color: Colors.black,
                ),
                Padding(padding: EdgeInsets.only(top: 25.0)),
                Text(
                  '${widget.weather.temperature?.celsius?.floor().toString()}°C',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lora(
                    textStyle: TextStyle(
                      fontSize: 65.0,
                      height: 1.2,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 5.0)),
                Text(
                  'Odczuwalna ${widget.weather.tempFeelsLike?.celsius?.floor().toString()}°C',
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
                Padding(padding: EdgeInsets.only(top: 20.0)),
                Text(
                  "${widget.weather.weatherDescription}",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lora(
                    textStyle: TextStyle(
                      fontSize: 18.0,
                      height: 1.2,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                Text(
                  '${DateFormat.yMMMEd().format(DateTime.now())}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lora(
                    textStyle: TextStyle(
                      fontSize: 15.0,
                      height: 1.2,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 30.0)),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Wiatr",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lora(
                                textStyle: TextStyle(
                                  fontSize: 18.0,
                                  height: 1.2,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 2.0)),
                            Text(
                              "${widget.weather.windSpeed} km/h",
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
                          ],
                        ),
                      ),
                      VerticalDivider(
                        width: 50,
                        color: Colors.black,
                        thickness: 3,
                      ),
                      Container(
                        width: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Porywy wiatru",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lora(
                                textStyle: TextStyle(
                                  fontSize: 18.0,
                                  height: 1.2,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 2.0)),
                            Text(
                              "${widget.weather.windGust} km/h",
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
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 25.0)),
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
                Padding(padding: EdgeInsets.only(top: 10.0)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String iconWeather(Weather weather) {
    var main = weather.weatherMain;
    if (main == 'Rain' ||
        main == 'Drizzle' ||
        main == "Snow" ||
        main == "Mist" ||
        main == "Hail" ||
        main == "Sleet") {
      return 'deszczowo';
    } else if (main == 'Thunderstorm') {
      return 'burza';
    } else if (main == "Clouds") {
      return 'chmurka';
    } else if (isNight(weather)) {
      return 'ksiezyc';
    } else {
      return 'pogoda';
    }
  }

  bool isNight(Weather weather) {
    return DateTime.now().isAfter(weather.sunset ?? DateTime.now()) ||
        DateTime.now().isBefore(weather.sunrise ?? DateTime.now());
  }

  LinearGradient getGradientByMood(Weather weather) {
    var main = weather.weatherMain;
    if (main == 'Rain' ||
        main == 'Drizzle' ||
        main == "Snow" ||
        main == "Mist" ||
        main == "Hail" ||
        main == "Sleet") {
      return LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          new Color(0xff33CCFF),
          new Color(0xff3399FF),
          new Color(0xff9999FF),
        ],
      );
    } else if (main == 'Thunderstorm') {
      return LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          new Color(0xffCC66CC),
          new Color(0xffCC6699),
          new Color(0xffCC6666),
        ],
      );
    } else if (main == "Clouds") {
      return LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          new Color(0xff66FF66),
          new Color(0xff6699FF),
          new Color(0xffFFCC66),
        ],
      );
    } else if (isNight(weather)) {
      return LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          new Color(0xff9999FF),
          new Color(0xff9999CC),
          new Color(0xff99CCCC),
        ],
      );
    } else {
      return LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          new Color(0xffFFCC66),
          new Color(0xffFFCC99),
          new Color(0xffFFFFCC),
        ],
      );
    }
  }
}
