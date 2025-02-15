import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String weatherBaseUrl = "https://api.open-meteo.com/v1/forecast";
  static const String locationBaseUrl = "http://ip-api.com/json";

  /// Fetches the user's city based on IP address
  static Future<String?> getUserCity() async {
    try {
      final response = await http.get(Uri.parse(locationBaseUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['city']; // Returns city name
      }
    } catch (e) {
      print("Error getting city: $e");
    }
    return null;
  }

  /// Fetches weather data for a given latitude and longitude
  static Future<Map<String, dynamic>?> getWeather(
      double lat, double lon) async {
    try {
      final url = Uri.parse(
        "$weatherBaseUrl?latitude=$lat&longitude=$lon&current_weather=true",
      );
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['current_weather'];
      }
    } catch (e) {
      print("Error fetching weather: $e");
    }
    return null;
  }

  /// Gets the current date and time in a formatted string
  static getCurrentDate() {
    final now = DateTime.now();
    String day = now.day.toString();
    String month = DateFormat('MMM').format(now); // Short month name (Aug)
    String year = now.year.toString();

    return "${day}${getDaySuffix(now.day)} $month. $year";
  }

  /// Returns the ordinal suffix for the day (st, nd, rd, th)
  static getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return "th"; // 11th, 12th, 13th (special case)
    }
    switch (day % 10) {
      case 1:
        return "st"; // 1st, 21st
      case 2:
        return "nd"; // 2nd, 22nd
      case 3:
        return "rd"; // 3rd, 23rd
      default:
        return "th"; // 4th, 5th, 6th, etc.
    }
  }

  /// Main function to get weather by city
  static Future<Map<String, dynamic>?> getWeatherByCity() async {
    String? city = await getUserCity();
    if (city == null) return null;

    // Use Open-Meteo's geocoding to get lat/lon
    final geoUrl = Uri.parse(
        "https://geocoding-api.open-meteo.com/v1/search?name=$city&count=1");
    final geoResponse = await http.get(geoUrl);
    if (geoResponse.statusCode == 200) {
      final geoData = jsonDecode(geoResponse.body);
      if (geoData['results'] != null && geoData['results'].isNotEmpty) {
        double lat = geoData['results'][0]['latitude'];
        double lon = geoData['results'][0]['longitude'];
        var weather = await getWeather(lat, lon);
        return {
          "city": city,
          "weather": weather,
          "date": getCurrentDate(),
        };
      }
    }
    return null;
  }
}
