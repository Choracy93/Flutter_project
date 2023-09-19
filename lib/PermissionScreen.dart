import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'SplashScreen.dart';
import 'package:weather/weather.dart';
import 'MyHomePage.dart';
import 'main.dart';

class PermissionScreen extends StatefulWidget {
  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  @override
  Widget build(BuildContext context) {
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
                  image: AssetImage('icons/attention.png'),
                ),
                Padding(padding: EdgeInsets.only(top: 15.0)),
                Text(
                  "Uwaga!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lora(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 45.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 5.0)),
                Text(
                  '${Strings.appTitle} potrzebuje do działania \n lokalizacji urządzenia \n (lokalizacja - w przybliżeniu)',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lora(
                    textStyle: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            bottom: 15,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 25.0, right: 25.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.only(top: 12.0, bottom: 12.0),
                    ),
                  ),
                  child: Text(
                    'Wyrażam zgodę',
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                  onPressed: () async {
                    LocationPermission permission = await Geolocator.requestPermission();
                    if (permission == LocationPermission.always ||
                        permission == LocationPermission.whileInUse) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SplashScreen()));
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
