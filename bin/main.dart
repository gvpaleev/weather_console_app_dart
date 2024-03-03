import 'dart:io';

import 'package:weather_console_app/weather_api_client.dart';

void main(List<String> arguments) async {
  // if (arguments.length != 1) {
  //   print('Syntax error: dart bin/main.dart <city>');
  //   return;
  // }

  // final String cityName = arguments.first;
  final String cityName = 'London';

  final weatherApiClient = WeatherApiClient();
  // Получение погоды сейчас.
  try {
    final currentWeather = await weatherApiClient.getCurrentWeather(cityName);

    print(currentWeather);
  } on WeatherApiException catch (error) {
    print('Error ${error.message}');
  } on SocketException catch (error) {
    print(
        'Could not featch current weather data. Check you interner connection');
  } catch (e) {
    print(e);
  }
  // Получение погоды на неделю.

  try {
    final weeklyForecast = await weatherApiClient.getWeeklyForecast(cityName);
    print('Weekly Forecast for $cityName');

    weeklyForecast.forEach((element) {
      print(element);
      print('---------------------\n');
    });
  } on WeatherApiException catch (error) {
    print('Error ${error.message}');
  } on SocketException catch (error) {
    print(
        'Could not featch current forecast data. Check you interner connection');
  } catch (e) {
    print(e);
  }
}
