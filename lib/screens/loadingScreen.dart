import 'package:flutter/material.dart';
import 'package:location_app/weather.dart';

import 'package:location_app/locationScreen.dart';

import 'package:loading_indicator/loading_indicator.dart';

const apiKey = 'def3fa1710d46034c43be51e57f019e0';

class LoadingScreen extends StatefulWidget {
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();
   

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingIndicator(
          indicatorType: Indicator.ballSpinFadeLoader,
          strokeWidth: 2.0,
          colors: [
            Colors.white10,
            Colors.blue,
            Colors.green,
            Colors.red,
            Colors.yellow,
            Colors.orange
          ],
        ),
      ),
    );
  }
}
