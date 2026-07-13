import 'dart:async';
import 'package:uuid/uuid.dart';
import '../models/user.dart';
import '../config/constants.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _apiService = ApiService();
  static final AuthService _instance = AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  Future<User> login(String email, String password) async {
    try {
      // API placeholder - replace with actual endpoint
      final response = await _apiService.post(
        AppConstants.loginEndpoint,
        {'email': email, 'password': password},
      );

      if (response['token'] != null) {
        _apiService.setAuthToken(response['token']);
        return User.fromJson(response['user']);
      }
      throw 'Invalid credentials';
    } catch (e) {
      throw 'Login failed: $e';
    }
  }

  Future<void> logout() async {
    try {
      await _apiService.post(AppConstants.logoutEndpoint, {});
      _apiService.clearAuthToken();
    } catch (e) {
      _apiService.clearAuthToken();
    }
  }

  Future<User> getCurrentUser() async {
    try {
      final response = await _apiService.get(AppConstants.getUserEndpoint);
      return User.fromJson(response['user']);
    } catch (e) {
      throw 'Failed to fetch user: $e';
    }
  }

  Future<User> signup(String name, String email, String password, String department) async {
    try {
      final response = await _apiService.post(
        '/auth/signup',
        {
          'name': name,
          'email': email,
          'password': password,
          'department': department,
        },
      );

      if (response['token'] != null) {
        _apiService.setAuthToken(response['token']);
        return User.fromJson(response['user']);
      }
      throw 'Signup failed';
    } catch (e) {
      throw 'Signup failed: $e';
    }
  }
}
