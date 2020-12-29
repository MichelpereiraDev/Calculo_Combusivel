import 'package:calculo_combustivel_simples/pageC.dart';

import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

// ignore: camel_case_types
class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Stack(children: <Widget>[
      SplashScreen(
        seconds:2,
        gradientBackground: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.amber,
            Colors.amber[900],
          ],
        ),
        navigateAfterSeconds: PageC(),
        loaderColor: Colors.transparent,
      ),
      Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.local_gas_station, size: 100, color: Colors.white),
          Text(
            "Vantagem Combustível",
            style: TextStyle(
              fontSize: 30,
              fontStyle: FontStyle.italic,
              
              
              color: Colors.white,
            ),
          ),
        ],
      ))
    ]));
  }
}
