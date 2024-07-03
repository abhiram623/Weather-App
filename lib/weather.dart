import 'package:location_app/networking.dart';
import 'package:location_app/location.dart';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName)async{
    var url = "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=def3fa1710d46034c43be51e57f019e0&units=metric";
    NetworkHelper networkHelper = NetworkHelper(url: "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=def3fa1710d46034c43be51e57f019e0&units=metric");
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

Future <dynamic> getLocationWeather() async{
   Location location = Location();
    await location.getCurentLocation();
    var latitude = location.latitude;
    var longitude = location.longitude;
    NetworkHelper networkHelper = NetworkHelper(
        url:
            "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=def3fa1710d46034c43be51e57f019e0&units=metric");
    var weatherData = await networkHelper.getData();
    return weatherData;
}
  
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔';
    } else if (condition < 700) {
      return '☃';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀';
    } else if (condition <= 804) {
      return '☁';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}