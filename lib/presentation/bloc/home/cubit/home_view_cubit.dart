import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/services/geolocator_services.dart';
import 'package:weather_app/core/services/models/result.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/data/repositories/weather_repository.dart';
import 'package:weather_app/presentation/bloc/home/cubit/home_view_cubit_state.dart';


class HomeViewCubit extends Cubit<HomeViewCubitState> {
  final WeatherRepository _weatherRepository = WeatherRepository();

  HomeViewCubit() : super(HomeViewCubitInitial()) {
    _init();
  }

  Future<void> _init() async {
    await getWeatherByLocation();
  }

  Future<void> getWeatherByLocation() async {
    final position = await GeolocatorServices.getCurrentLocation();

    if (position != null) {
      final Result result = await _weatherRepository.getWeatherByLocation(position);

      _result(result);
    }
  }

  Future<void> getWeatherByCity(String city) async {
    final Result result = await _weatherRepository.getWeatherByCityName(city);
    _result(result);
  }

  void _result(Result result) {
    if (result is Success) {
      final weatherModel = WeatherModel.fromJson(result.data);

      emit(HomeViewCubitSuccess(weatherModel: weatherModel));
    } else {
      final error = (result as Failure).error;
      final statusCode = result.statusCode.toString();

      emit(HomeViewCubitError(error: error, statusCode: statusCode));
    }
  }
}