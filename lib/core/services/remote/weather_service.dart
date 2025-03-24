import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String weatherBaseUrl = "https://api.open-meteo.com/v1/forecast";
  static const String googleGeocodeBaseUrl =
      "https://maps.googleapis.com/maps/api/geocode/json";
  static const String googleApiKey =
      "AIzaSyDab6c_jc-y8w04LbEWN4uh1Q-7sWOzBSI"; // Replace with your API key

  /// Fetches the user's current location (latitude & longitude)
  static Future<Position?> getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location services are disabled.");
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location permission denied.");
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Location permissions are permanently denied.");
      return null;
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  /// Fetches the city name using Google Geocoding API based on latitude & longitude
  static Future<String?> getCityFromLocation(
      double lat, double lon, BuildContext context) async {
    String languageCode = Localizations.localeOf(context).languageCode;
    final url = Uri.parse(
        "$googleGeocodeBaseUrl?latlng=$lat,$lon&key=$googleApiKey&language=$languageCode");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['results'] != null && data['results'].isNotEmpty) {
          for (var result in data['results']) {
            for (var component in result['address_components']) {
              if (component['types'].contains("locality")) {
                return component['long_name']; // City name
              }
            }
          }
        }
      }
    } catch (e) {
      print("Error fetching city: $e");
    }
    return null;
  }

  /// Fetches weather data for a given latitude and longitude
  static Future<Map<String, dynamic>?> getWeather(
      double lat, double lon) async {
    try {
      final url = Uri.parse(
          "$weatherBaseUrl?latitude=$lat&longitude=$lon&current_weather=true");

      final response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['current_weather'];
      }
    } catch (e) {
      print("Error fetching weather: $e");
    }
    return null;
  }

  /// Gets the current date formatted as "dd MMM yyyy"
  static String getCurrentDate(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    final now = DateTime.now();
    return DateFormat('dd MMM yyyy', locale.languageCode).format(now);
  }

  /// Fetches weather details using user's current location
  static Future<Map<String, dynamic>?> getWeatherByUserLocation(
      BuildContext context) async {
    Position? position;

    try {
      position = await getUserLocation();
    } catch (e) {
      print("Error getting user location: $e");
    }

    // Default to Cairo if location is not available
    double latitude = position?.latitude ?? 30.0444;
    double longitude = position?.longitude ?? 31.2357;

    String? city = await getCityFromLocation(latitude, longitude, context);
    if (city == null) city = "cairo".tr(); // Ensure default city name

    var weather = await getWeather(latitude, longitude);
    return {
      "city": city,
      "weather": weather,
      "date": getCurrentDate(context),
    };
  }
}
