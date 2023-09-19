import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'SplashScreen.dart';
import 'MyHomePage.dart';
import 'PermissionScreen.dart';
import 'main.dart';

class AirQualityScreen extends StatefulWidget {

  final AirPurity air;

  AirQualityScreen({required this.air});


 // const AirQualityScreen({super.key});

  @override
  State<AirQualityScreen> createState() => _AirQualityScreenState();
}

class _AirQualityScreenState extends State<AirQualityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: new Color(0xffffffff),
              gradient: getGradientByMood(widget.air)),
        ),
        Align(
            alignment: FractionalOffset.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Jakość powietrza:",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lora(
                      textStyle: TextStyle(
                          fontSize: 15.0,
                          height: 1.2,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                ),
                Padding(padding: EdgeInsets.only(top: 2)),
                Text(
                  widget.air.quality,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lora(
                      textStyle: TextStyle(
                          fontSize: 25.0,
                          height: 1.2,
                          color: Colors.black,
                          fontWeight: FontWeight.w800)),
                ),
                Padding(padding: EdgeInsets.only(top: 20)),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 90.0,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          (widget.air.aqi/200*100).floor().toString(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lora(
                              textStyle: TextStyle(
                                  fontSize: 60.0,
                                  height: 1.2,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Text(
                          "CAQI",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lora(
                              textStyle: TextStyle(
                                  fontSize: 18.0,
                                  height: 1.2,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600)),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 25)),
                IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "PM 2,5",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lora(
                                    textStyle: TextStyle(
                                        fontSize: 15.0,
                                        height: 1.2,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400)),
                              ),
                              Padding(padding: EdgeInsets.only(top: 2.0)),
                              Text(
                                widget.air.pm2_5.toString() + "%",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lora(
                                    textStyle: TextStyle(
                                        fontSize: 20.0,
                                        height: 1.2,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800)),
                              ),
                            ],
                          ),
                        ),
                        VerticalDivider(
                          width: 25,
                          color: Colors.black,
                          thickness: 3,
                        ),
                        Container(
                          width: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "PM 10",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lora(
                                    textStyle: TextStyle(
                                        fontSize: 15.0,
                                        height: 1.2,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400)),
                              ),
                              Padding(padding: EdgeInsets.only(top: 2.0)),
                              Text(
                                widget.air.pm10.toString() + "%",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lora(
                                    textStyle: TextStyle(
                                        fontSize: 20.0,
                                        height: 1.2,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800)),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
                Padding(padding: EdgeInsets.only(top: 20)),
                Text("Wybrana stacja pomiarowa:",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lora(
                      textStyle: TextStyle(
                          fontSize: 15.0,
                          height: 1.2,
                          color: Colors.black,
                          fontWeight: FontWeight.w400)),),
                Padding(padding: EdgeInsets.only(top: 10)),
                Text(
                  widget.air.station,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lora(
                      textStyle: TextStyle(
                          fontSize: 20.0,
                          height: 1.2,
                          color: Colors.black,
                          fontWeight: FontWeight.w700)),
                ),
                Padding(padding: EdgeInsets.only(top: 20)),
              ],
            )),
        Positioned(
            left: 10,
            bottom: 40,
            top: 0,
            right: 0,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Stack(
                children: [
                  ClipRect(
                    child: Align(
                      alignment: Alignment.topLeft,
                      heightFactor: 1,
                      child: Image.asset('icons/danger2.png', scale: 0.7),
                    ),
                  ),
                  ClipRect(
                    child: Align(
                      alignment: Alignment.topLeft,
                      heightFactor: 1 - widget.air.aqi/200.floor(),
                      child: Image.asset(
                          'icons/danger1.png', color: Color(0xDD4ACF8C),
                          scale: 0.7),
                    ),
                  )
                ],
              ),
            )),
      ]), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  bool havePermission() {
    return true;
  }

  LinearGradient getGradientByMood(AirPurity air) {
    if (air.isGood) {
      return LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            new Color(0xff99FF66),
            new Color(0xff99FF99),
            new Color(0xff99FFCC),
          ]);
    } else if (air.isNormal) {
      return LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            new Color(0xff33CC66),
            new Color(0xff99FF99),
            new Color(0xff99FFCC),
          ]);
    } else if (air.isNeutral) {
      return LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            new Color(0xff33CC66),
            new Color(0xffFF9933),
            new Color(0xff99FFCC),
          ]);
    } else if (air.isBad) {
      return LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            new Color(0xffFF9966),
            new Color(0xffFF9933),
            new Color(0xffFF9900),
          ]);
    } else {
      return LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            new Color(0xffFF3333),
            new Color(0xffFF0033),
            new Color(0xffCC0000),
          ]);
    }
  }
}
