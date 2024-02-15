import 'package:weather_app/data/models/weather_model.dart';

abstract class HomeViewCubitState {}

class HomeViewCubitInitial extends HomeViewCubitState {}

class HomeViewCubitError extends HomeViewCubitState {
  final String error;
  final String statusCode;

  HomeViewCubitError({
    required this.error,
    required this.statusCode,
  });
}

class HomeViewCubitSuccess extends HomeViewCubitState {
  final WeatherModel weatherModel;

  HomeViewCubitSuccess({required this.weatherModel});
}


