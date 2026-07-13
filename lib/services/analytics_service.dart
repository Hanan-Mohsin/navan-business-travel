import '../config/constants.dart';
import 'api_service.dart';

class AnalyticsService {
  final ApiService _apiService = ApiService();
  static final AnalyticsService _instance = AnalyticsService._internal();

  factory AnalyticsService() {
    return _instance;
  }

  AnalyticsService._internal();

  // Get spending summary
  Future<Map<String, dynamic>> getSpendingSummary() async {
    try {
      final response = await _apiService.get(AppConstants.getAnalyticsEndpoint);
      return response['summary'] ?? {};
    } catch (e) {
      throw 'Failed to fetch spending summary: $e';
    }
  }

  // Get spending by category
  Future<Map<String, double>> getSpendingByCategory() async {
    try {
      final response = await _apiService.get('${AppConstants.getAnalyticsEndpoint}/category');
      final Map<String, double> result = {};
      (response['data'] as List).forEach((item) {
        result[item['category']] = (item['total'] as num).toDouble();
      });
      return result;
    } catch (e) {
      throw 'Failed to fetch spending by category: $e';
    }
  }

  // Get spending by month
  Future<Map<String, double>> getSpendingByMonth(int year) async {
    try {
      final response = await _apiService.get(
        '${AppConstants.getAnalyticsEndpoint}/monthly?year=$year',
      );
      final Map<String, double> result = {};
      (response['data'] as List).forEach((item) {
        result[item['month']] = (item['total'] as num).toDouble();
      });
      return result;
    } catch (e) {
      throw 'Failed to fetch monthly spending: $e';
    }
  }

  // Get policy violations
  Future<List<Map<String, dynamic>>> getPolicyViolations() async {
    try {
      final response = await _apiService.get('${AppConstants.getAnalyticsEndpoint}/violations');
      return List<Map<String, dynamic>>.from(response['violations'] ?? []);
    } catch (e) {
      throw 'Failed to fetch policy violations: $e';
    }
  }
}
