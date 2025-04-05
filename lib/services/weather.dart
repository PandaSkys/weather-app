import 'dart:convert';
import 'package:http/http.dart' as http;

class Weather {
  final double temperature;
  final double windSpeed;

  Weather({required this.temperature, required this.windSpeed});

  factory Weather.fromJson(Map<String, dynamic> json) {
    final current = json['current_weather'];
    return Weather(
      temperature: current['temperature'].toDouble(),
      windSpeed: current['windspeed'].toDouble(),
    );
  }
}

class WeatherService {
  Future<Weather> getWeather(double lat, double lon) async {
    final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Weather.fromJson(data);
    } else {
      throw Exception('Échec de récupération des données météo');
    }
  }
}
