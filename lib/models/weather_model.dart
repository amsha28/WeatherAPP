class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final int humidity;
  final double uvIndex;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.humidity,
    required this.uvIndex,
  });

  factory Weather.fromJson(Map<String, dynamic> json, double uvIndex) {
    return Weather(
      cityName: json['name'],
      temperature: (json['main']['temp'] as num).toDouble(),
      mainCondition: json['weather'][0]['main'],
      humidity: json['main']['humidity'] as int,
      uvIndex: uvIndex,
    );
  }
}
