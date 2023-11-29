import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myweatherapp/models/weather_model.dart';
import 'package:myweatherapp/services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _WeatherService = WeatherService('88be96b2906bcbfa96545fdbbb83a6e9');
  Weather? _weather;
  //fetch weather
  _fetchWeather() async {
    //weather animations
    String cityName = await _WeatherService.getCurrentCity();

    //get weather for city

    try {
      final weather = await _WeatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    //any errors
    catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json'; // default sunny

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      case 'snow':
        return 'assets/snow.json';
      default:
        return 'assets/sunny.json';
    }
  }

  // weather animations

  //init state
  @override
  void initState() {
    //fetch the weather
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Icon(
              Icons.location_on,
              color: Colors.grey[500],
              size: 40,
            ),
            Text(
              _weather?.CityName ?? "loading city..",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Bebas Neue',
                  color: Colors.grey[500]),
            ),

            //animations
            Lottie.asset(getWeatherAnimation(_weather?.MainCondition)),

            //temperature
            Text('${_weather?.Temperature.round()}°C',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[500])),

            //weather condition
            Text(_weather?.MainCondition ?? "",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[500])),
          ],
        ),
      ),
    );
  }
}
