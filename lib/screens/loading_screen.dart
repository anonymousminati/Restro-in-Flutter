import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:geolocator/geolocator.dart';
import 'package:restro/screens/homepage.dart';
import 'package:restro/utils/api_services.dart';

import 'package:restro/utils/location.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({super.key});
  static const String id = '/loading_screen';

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  LocationService _locationService = LocationService();
  ApiService _apiService = ApiService();
  Position? currentLocation;
  List<Map<String, dynamic>> restaurants = [];

  double latitude = 0.0;
  double longitude = 0.0;
  String? currentLocationName;
  Map<String, dynamic> apiResponse = {};

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
    currentLocation = await _locationService.getLocation();

    if (currentLocation != null) {
      latitude = currentLocation!.latitude;
      longitude = currentLocation!.longitude;
      //TODO: uncomment above two lines and comment below two lines for production use
      // latitude = 25.22;
      // longitude = 45.32;
      print("Latitude: $latitude, Longitude: $longitude");

      try {
        apiResponse = await _apiService.getRestaurants(latitude, longitude);
        if (apiResponse['status'] == 'SUCCESS') {
          restaurants = List<Map<String, dynamic>>.from(apiResponse['data']);
          print("Fetched ${restaurants.length} restaurants");

          setState(() {}); // Trigger a rebuild to show the HomePage widget
        } else {
          // Handle API error
          print("API error: ${apiResponse['message']}");
        }
      } catch (e) {
        // Handle other errors
        print("Error: $e");
      }
    } else {
      // Show an error message or navigate to an error screen
      print("Failed to get current location");
    }

    print('current location: $currentLocationName');
  }

  @override
  Widget build(BuildContext context) {
    return currentLocation != null
        ? HomePage(
            latitude: latitude,
            longitude: longitude,
            locationName:
                _locationService.locationName, // Pass locationName to HomePage

            restaurantResponse: apiResponse,
          )
        : Center(child: CircularProgressIndicator());
  }
}
