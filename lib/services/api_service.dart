import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Quote API Configuration
  static const String _quoteBaseUrl = 'https://api.quotable.io';

  // Weather API Configuration (Optional - you can use this instead)
  static const String _weatherBaseUrl =
      'https://api.openweathermap.org/data/2.5';
  // Note: You would need to sign up for a free API key at openweathermap.org
  static const String _weatherApiKey = 'YOUR_API_KEY_HERE';

  // Fetch random motivational quote
  static Future<Map<String, dynamic>> fetchMotivationalQuote() async {
    try {
      final response = await http.get(
        Uri.parse('$_quoteBaseUrl/random?tags=motivational|inspirational'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        throw Exception('No quotes found');
      } else if (response.statusCode == 429) {
        throw Exception('Too many requests. Please try again later.');
      } else {
        throw Exception('Failed to load quote. Status: ${response.statusCode}');
      }
    } on http.ClientException {
      throw Exception('Network error. Please check your internet connection.');
    } on FormatException {
      throw Exception('Invalid data format received from server.');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  // Fetch quotes by category
  static Future<Map<String, dynamic>> fetchQuoteByTag(String tag) async {
    try {
      final response = await http.get(
        Uri.parse('$_quoteBaseUrl/random?tags=$tag'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load quote. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching quote: $e');
    }
  }

  // Fetch list of available tags (for categories)
  static Future<List<String>> fetchAvailableTags() async {
    try {
      final response = await http.get(
        Uri.parse('$_quoteBaseUrl/tags'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((tag) => tag['name'].toString()).toList();
      } else {
        throw Exception('Failed to load tags. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching tags: $e');
    }
  }

  // Weather API Methods (Optional)
  static Future<Map<String, dynamic>> fetchWeatherByCity(String city) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$_weatherBaseUrl/weather?q=$city&appid=$_weatherApiKey&units=metric'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        throw Exception('City not found');
      } else if (response.statusCode == 401) {
        throw Exception('Invalid API key');
      } else {
        throw Exception(
            'Failed to load weather. Status: ${response.statusCode}');
      }
    } on http.ClientException {
      throw Exception('Network error. Please check your internet connection.');
    } catch (e) {
      throw Exception('Error fetching weather: $e');
    }
  }

  // Fetch weather by coordinates
  static Future<Map<String, dynamic>> fetchWeatherByCoordinates(
      double lat, double lon) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$_weatherBaseUrl/weather?lat=$lat&lon=$lon&appid=$_weatherApiKey&units=metric'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Failed to load weather. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching weather: $e');
    }
  }
}