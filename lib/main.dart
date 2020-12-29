import 'package:calculo_combustivel_simples/splash.dart';

import 'package:flutter/material.dart';

void main() {
  
  runApp(MyApp());
}






class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      title: 'Combustivel',
      theme: ThemeData(
        fontFamily: 'Josefins',
        primarySwatch: Colors.amber,
      ),
      home: splash(),
    );
  }



  
}
