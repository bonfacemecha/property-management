import 'dart:convert';
import 'package:http/http.dart' as http;

// Set up your backend server URL (ensure this matches your Laravel backend URL)
const String baseUrl = 'http://localhost:8000/api/properties';

class ApiService {
  // Fetch all properties
  static Future<List<dynamic>> fetchProperties() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load properties');
    }
  }

  // Add a new property
  static Future<void> addProperty(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add property');
    }
  }

  // Update a property
  static Future<void> updateProperty(int id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update property');
    }
  }
  

  // Delete a property
  static Future<void> deleteProperty(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete property');
    }
  }
}
