import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/constants.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  String? _authToken;

  factory ApiService() {
    return _instance;
  }

  ApiService._internal();

  void setAuthToken(String token) {
    _authToken = token;
  }

  void clearAuthToken() {
    _authToken = null;
  }

  Map<String, String> get _headers {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (_authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }
    return headers;
  }

  // Generic GET request
  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final url = Uri.parse('${AppConstants.apiBaseUrl}${AppConstants.apiVersion}$endpoint');
      final response = await http
          .get(url, headers: _headers)
          .timeout(AppConstants.apiTimeout);

      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Generic POST request
  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body) async {
    try {
      final url = Uri.parse('${AppConstants.apiBaseUrl}${AppConstants.apiVersion}$endpoint');
      final response = await http
          .post(url, headers: _headers, body: jsonEncode(body))
          .timeout(AppConstants.apiTimeout);

      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Generic PUT request
  Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> body) async {
    try {
      final url = Uri.parse('${AppConstants.apiBaseUrl}${AppConstants.apiVersion}$endpoint');
      final response = await http
          .put(url, headers: _headers, body: jsonEncode(body))
          .timeout(AppConstants.apiTimeout);

      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Generic DELETE request
  Future<Map<String, dynamic>> delete(String endpoint) async {
    try {
      final url = Uri.parse('${AppConstants.apiBaseUrl}${AppConstants.apiVersion}$endpoint');
      final response = await http
          .delete(url, headers: _headers)
          .timeout(AppConstants.apiTimeout);

      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      throw 'Unauthorized: Please login again';
    } else if (response.statusCode == 404) {
      throw 'Not Found';
    } else if (response.statusCode == 500) {
      throw 'Server Error: Please try again later';
    } else {
      throw 'Error: ${response.statusCode}';
    }
  }

  String _handleError(dynamic error) {
    if (error is String) return error;
    if (error.toString().contains('TimeoutException')) {
      return 'Request timeout. Please check your connection.';
    }
    return 'An error occurred: $error';
  }
}
