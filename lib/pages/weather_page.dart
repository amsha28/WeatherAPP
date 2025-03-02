import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/models/weather_model.dart';
import 'package:myapp/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // API Key
  final WeatherService _weatherService = WeatherService(
    '256f015e5c78f71caf2801a7bbc3bf86',
  );
  Weather? _weather;

  // Fetch weather
  _fetchWeather() async {
    try {
      // Get the current city
      String cityName = await _weatherService.getCurrentCity();

      // Get the weather for the city
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      debugPrint(e.toString()); // Menggunakan debugPrint
    }
  }

  // Weather Animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json'; // default to sunny

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'snow':
        return 'assets/snow.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  // UV Index Color
  Color getUvColor(double uvIndex) {
    if (uvIndex < 3) return Colors.green;
    if (uvIndex < 6) return Colors.yellow;
    if (uvIndex < 8) return Colors.orange;
    if (uvIndex < 11) return Colors.red;
    return Colors.purple;
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 65, 68, 85),
      appBar: AppBar(title: const Text('WEATHER APP'), centerTitle: true),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // City name
            Text(
              _weather?.cityName ?? "Loading City...",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Animation
            if (_weather != null)
              Lottie.asset(
                getWeatherAnimation(_weather!.mainCondition),
                width: 200,
                height: 200,
              )
            else
              const CircularProgressIndicator(),

            const SizedBox(height: 20),

            // Temperature
            if (_weather != null)
              Text(
                '${_weather!.temperature.round()}°C',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

            const SizedBox(height: 10),

            // Weather condition
            if (_weather != null)
              Text(
                _weather!.mainCondition,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),

            const SizedBox(height: 10),

            // Humidity
            if (_weather != null)
              Text(
                'Humidity: ${_weather!.humidity}%',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),

            const SizedBox(height: 10),

            // UV Index
            if (_weather != null)
              Text(
                'UV Index: ${_weather!.uvIndex}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: getUvColor(_weather!.uvIndex),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
