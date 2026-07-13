import 'package:get/get.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class UserController extends GetxController {
  final AuthService _authService = AuthService();
  final Rx<User?> user = Rx<User?>(null);
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxBool isLoggedIn = false.obs;

  // Login
  Future<bool> login(String email, String password) async {
    isLoading.value = true;
    error.value = '';

    try {
      user.value = await _authService.login(email, password);
      isLoggedIn.value = true;
      isLoading.value = false;
      return true;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
      return false;
    }
  }

  // Signup
  Future<bool> signup(String name, String email, String password, String department) async {
    isLoading.value = true;
    error.value = '';

    try {
      user.value = await _authService.signup(name, email, password, department);
      isLoggedIn.value = true;
      isLoading.value = false;
      return true;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    isLoading.value = true;

    try {
      await _authService.logout();
      user.value = null;
      isLoggedIn.value = false;
      error.value = '';
      isLoading.value = false;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
    }
  }

  // Get current user
  Future<void> getCurrentUser() async {
    isLoading.value = true;

    try {
      user.value = await _authService.getCurrentUser();
      isLoggedIn.value = true;
      isLoading.value = false;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
    }
  }

  // Clear error
  void clearError() {
    error.value = '';
  }
}
