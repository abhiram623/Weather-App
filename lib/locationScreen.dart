import 'package:flutter/material.dart';
import 'package:location_app/city_screen.dart';
import 'package:location_app/constants.dart';
import 'package:location_app/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  WeatherModel weather =WeatherModel(); 

   int? temperature;
  dynamic weatherIcon;
  String? cityName;
  dynamic tempMessage;

 
  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }
  void updateUI(dynamic weatherData){
    setState(() {
      
      if(weatherData == null){
        temperature = 0;
        weatherIcon = "error";
        tempMessage = "Unable to get message";
        cityName = "";
        return;
      }
    
    dynamic temp = weatherData['main']['temp'];
     temperature = temp.toInt();
   tempMessage = weather.getMessage(temperature!);
    var condition = weatherData['weather'][0]['id'];
    weatherIcon= weather.getWeatherIcon(condition);
   cityName = weatherData['name'];
   });
   print(temperature);
   print(widget.locationWeather);
   print(cityName);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MaterialButton(
                    onPressed: ()async {

                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  MaterialButton(
                    onPressed: () async{
                     var typedName = await Navigator.push(context, MaterialPageRoute(builder: (context)
                      {
                        return CityScreen();
                      }
                      ),
                      );
                      if(typedName !=null){
                       var weatherData=await weather.getCityWeather(typedName);
                       updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$tempMessage in $cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
