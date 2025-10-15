import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  final http.Client _client;

  HttpService({http.Client? client}) : _client = client ?? http.Client();

  Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await _client.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'TechnicalTest.Flutter/1.0',
      },
    ).timeout(const Duration(seconds: 5));
    
    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      final errorBody = json.decode(response.body.toString());
      throw Exception(
        'Failed to load data: ${response.statusCode}\n'
        'Message: ${errorBody['message'] ?? 'Unknown error'}\n'
        'Details: ${response.body}',
      );
    }
  }

  Future<List<Map<String, dynamic>>> getList(String endpoint) async {
    final response = await _client.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'TechnicalTest.Flutter/1.0',
      },
    ).timeout(const Duration(seconds: 5));
    
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.cast<Map<String, dynamic>>();
    } else {
      final errorBody = json.decode(response.body.toString());
      throw Exception(
        'Failed to load data: ${response.statusCode}\n'
        'Message: ${errorBody['message'] ?? 'Unknown error'}\n'
        'Details: ${response.body}',
      );
    }
  }

  void dispose() {
    _client.close();
  }
}