class Weather {
  final String lastUpdated;
  final String citiName;
  final String tempC;
  final String feelsLinkeC;
  final String condition;

  Weather(
      {required this.lastUpdated,
      required this.citiName,
      required this.tempC,
      required this.feelsLinkeC,
      required this.condition});

  factory Weather.fromJson(Map<String, dynamic> json) {
    final currentData = json['current'];
    final location = json['location'];
    final conditionData = currentData['condition'];

    return Weather(
        lastUpdated: currentData['last_updated'],
        citiName: location['name'],
        tempC: currentData['temp_c'].toString(),
        feelsLinkeC: currentData['feelslike_c'].toString(),
        condition: conditionData['text']);
  }

  @override
  String toString() => '''
  Last updated: $lastUpdated
  Temperature: $tempC C
  Feels like: $feelsLinkeC C
  Weather condition $condition
''';
}

class Forecast {
  final String data;
  final String minTempC;
  final String maxTempC;
  final String condition;

  Forecast(
      {required this.data,
      required this.minTempC,
      required this.maxTempC,
      required this.condition});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    final conditionData = json['day']['condition'];
    return Forecast(
        data: json['date'],
        minTempC: json['day']['mintemp_c'].toString(),
        maxTempC: json['day']['maxtemp_c'].toString(),
        condition: conditionData['text']);
  }

  @override
  String toString() => '''
  Date: $data
  Temperature: $minTempC C - $maxTempC C
  Weather condition $condition
''';
}
