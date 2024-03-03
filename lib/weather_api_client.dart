import 'package:dio/dio.dart';
import 'package:weather_console_app/config.dart';
import 'package:weather_console_app/weather.dart';

class WeatherApiClient {
  Future<Weather> getCurrentWeather(String cityName) async {
    //https://api.weatherapi.com/v1/current.json?key=fddf92f56c6a4919b06142205240303&q=London&aqi=no
    final url =
        '${Config().baseUrl}/${Config().currentUrl}?key=${Config().apiKey}&q=$cityName';
    print(url);
    final response = await Dio().get(url);

    if (response.statusCode != 200) {
      print('Request failed with status: ${response.statusCode}');
      throw WeatherApiException('Error getting weather for $cityName');
    }

    final Map<String, dynamic> jsonRespons = response.data;

    if (jsonRespons.isEmpty) {
      print('Weather data for $cityName not found');
      throw WeatherApiException('Weather data for $cityName not found');
    }

    return Weather.fromJson(jsonRespons);
  }

  Future<List<Forecast>> getWeeklyForecast(String cityName) async {
    //https://api.weatherapi.com/v1/forecast.json?key=fddf92f56c6a4919b06142205240303&q=London&days=7&aqi=no&alerts=no
    final url =
        '${Config().baseUrl}/${Config().forecastUrl}?key=${Config().apiKey}&q=$cityName&days=7';
    print(url);
    final response = await Dio().get(url);

    if (response.statusCode != 200) {
      print('Request failed with status: ${response.statusCode}');
      throw WeatherApiException('Error getting forecast for $cityName');
    }

    final List<dynamic> listRespons = response.data['forecast']['forecastday'];
    final List<Map<String, dynamic>> listJsonRespons = listRespons
        .map<Map<String, dynamic>>((e) => e as Map<String, dynamic>)
        .toList();

    if (listJsonRespons.isEmpty) {
      print('Weather data for $cityName not found');
      throw WeatherApiException('Forecast data for $cityName not found');
    }

    return listJsonRespons
        .map((forecastData) => Forecast.fromJson(forecastData))
        .toList();
  }
}

class WeatherApiException implements Exception {
  final String message;

  const WeatherApiException(this.message);
}
