import 'package:flutter/material.dart';
import 'package:myweatherapp/views/weather_app.dart';

void main() {
  runApp(weatherApp());
}

class weatherApp extends StatelessWidget {
  const weatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Bebas Neue',
      ),
      debugShowCheckedModeBanner: false,
      home: WeatherPage(),
    );
  }
}
