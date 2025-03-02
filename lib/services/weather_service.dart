import '../models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class WeatherService {
  static const String baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';
  static const String uvBaseUrl = 'https://api.openweathermap.org/data/2.5/uvi';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(
      Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      final weatherData = jsonDecode(response.body);
      final double lat = weatherData['coord']['lat'];
      final double lon = weatherData['coord']['lon'];
      final double uvIndex = await getUvIndex(lat, lon);

      return Weather.fromJson(weatherData, uvIndex);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<double> getUvIndex(double lat, double lon) async {
    final response = await http.get(
      Uri.parse('$uvBaseUrl?lat=$lat&lon=$lon&appid=$apiKey'),
    );

    if (response.statusCode == 200) {
      final uvData = jsonDecode(response.body);
      return uvData['value'].toDouble();
    } else {
      throw Exception('Failed to load UV index');
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    String? city = placemarks[0].locality;
    return city ?? "";
  }
}
