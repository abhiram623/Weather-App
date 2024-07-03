import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double ?longitude;

   Future <void> getCurentLocation() async {
       

LocationPermission permission = await Geolocator.requestPermission();
print(permission);
    try{
      

Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
   
   latitude = position.latitude;
   longitude = position.longitude;


    }
    catch(e){
      print(e);
    }
  }

}