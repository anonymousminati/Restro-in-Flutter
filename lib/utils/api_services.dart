import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://theoptimiz.com/restro/public/api";

  Future<Map<String, dynamic>> getRestaurants(double lat, double lng) async {
    final String apiUrl = "$baseUrl/get_resturants";
    final Map<String, dynamic> requestBody = {"lat": lat, "lng": lng};

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode(requestBody), // Convert requestBody to JSON
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print(
            "API error - Status Code: ${response.statusCode}, Response: ${response.body}");
        throw Exception(
            "Failed to fetch restaurants. Server responded with status ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching restaurants: $e");
      throw Exception("Failed to fetch restaurants. Error: $e");
    }
  }
}
