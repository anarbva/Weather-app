
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/services/models/result.dart';
import 'package:weather_app/core/services/http_services.dart';

class WeatherServices{
 
Future<Result> getWeatherByCityName(String city)async{
 return await HttpServices.get(endpoint: 'q=$city');
 
}
  
Future<Result>getWeatherByLocation(Position position)async{
   return await HttpServices.get(
    endpoint:'lat=${position.latitude}&lon=${position.longitude}',
    );  
  }
}

final WeatherServices weatherServices = WeatherServices();