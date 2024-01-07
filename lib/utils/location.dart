import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  late Geolocator _geolocator;
  String? locationName;
  LocationService() {
    _geolocator = Geolocator();
  }

  Future<bool> checkLocationPermission() async {
    LocationPermission permission;

    try {
      permission = await Geolocator.checkPermission();
    } catch (e) {
      print("Error checking location permission: $e");
      return false;
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    } else {
      return await requestLocationPermission();
    }
  }

  Future<bool> requestLocationPermission() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      return permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse;
    } catch (e) {
      print("Error requesting location permission: $e");
      return false;
    }
  }

  Future<Position?> getCurrentLocation() async {
    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      print("Error getting current location: $e");
      return null;
    }
  }

  Future<bool> isLocationServiceEnabled() async {
    bool isServiceEnabled;

    try {
      isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      return isServiceEnabled;
    } catch (e) {
      print("Error checking if location service is enabled: $e");
      return false;
    }
  }

  Future<Position?> getLocation() async {
    try {
      if (await checkLocationPermission()) {
        if (await isLocationServiceEnabled()) {
          return await getCurrentLocation();
        } else {
          print("Location service is not enabled");
          // Handle this case, show a message to the user, etc.
          return null;
        }
      } else {
        print("Location permission not granted");
        // Handle this case, show a message to the user, etc.
        return null;
      }
    } catch (e) {
      print("Error getting location: $e");
      return null;
    }
  }

  Future<String?> getLocationName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        locationName = placemarks[0].name ?? 'Unknown Location';
        print("Location Name: $locationName");
      } else {
        print("No address information found");
      }
    } catch (e) {
      print("Error getting location name: $e");
      return null;
    }
  }
}
