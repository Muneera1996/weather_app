import 'package:flutter/foundation.dart';
import 'package:weather_app/WeatherForecast/model/weather_forecast_model.dart';
import 'package:weather_app/WeatherForecast/network/network.dart';

class WeatherNotifier extends ChangeNotifier {
  static final WeatherNotifier weatherNotifier = WeatherNotifier._internal();
  factory WeatherNotifier() => weatherNotifier;
  Future<WeatherForecastModel> weatherForecast;

  WeatherNotifier._internal() {
    print('Weather App');
    searchWeatherForecast('Lahore');
  }

  void searchWeatherForecast(String cityName) {
    weatherForecast = setWeatherForecast(cityName: cityName);
    notifyListeners();
  }
  Future<WeatherForecastModel> setWeatherForecast({String cityName}) => Network().getWeatherForecast(cityName: cityName);

  Future<WeatherForecastModel> getWeatherForecast(){
    return weatherForecast;
  }

}