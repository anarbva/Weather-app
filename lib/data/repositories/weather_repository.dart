import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/services/models/result.dart';
import 'package:weather_app/data/sources/weather_services.dart';

class WeatherRepository{

  Future<Result>getWeatherByCityName(String city)async{
    return await weatherServices.getWeatherByCityName(city);
  }

   Future<Result>getWeatherByLocation(Position position)async{
    return await weatherServices.getWeatherByLocation(position);
  }
}

final WeatherRepository weatherRepository = WeatherRepository();