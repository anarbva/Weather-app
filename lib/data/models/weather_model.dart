import 'package:weather_app/core/utils/convert_units_services.dart';

class WeatherModel {

  List<Weather>? weather;
   Main? main;
 

  WeatherModel(
      {
      this.weather,
      this.main,
   });

  WeatherModel.fromJson(Map<String, dynamic> json) {
    
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add( Weather.fromJson(v));
      });
    }
   
    main = json['main'] != null ? Main.fromJson(json['main']) : null;
   

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
 
    if (weather != null) {
      data['weather'] = weather!.map((v) => v.toJson()).toList();
    }
   
    if (main != null) {
      data['main'] = main!.toJson();
    }
   
    return data;
  }
}



class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['main'] = main;
    data['description'] = description;
    data['icon'] = icon;
    return data;
  }
}

class Main {
  num? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;

  Main(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.humidity});

  Main.fromJson(Map<String, dynamic> json) {
    temp = ConvertUnitsServices.kelvinToCelcius(
    json['temp']);
    feelsLike = json['feels_like'];
    tempMin = json['temp_min'];
    tempMax = json['temp_max'];
    pressure = json['pressure'];
    humidity = json['humidity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['temp_min'] = tempMin;
    data['temp_max'] = tempMax;
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    return data;
  }
}



