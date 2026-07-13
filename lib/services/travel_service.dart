import '../models/trip.dart';
import '../models/expense.dart';
import '../config/constants.dart';
import 'api_service.dart';

class TravelService {
  final ApiService _apiService = ApiService();
  static final TravelService _instance = TravelService._internal();

  factory TravelService() {
    return _instance;
  }

  TravelService._internal();

  // Get all trips for current user
  Future<List<Trip>> getTrips() async {
    try {
      final response = await _apiService.get(AppConstants.getTripsEndpoint);
      final List<dynamic> trips = response['trips'] ?? [];
      return trips.map((trip) => Trip.fromJson(trip as Map<String, dynamic>)).toList();
    } catch (e) {
      throw 'Failed to fetch trips: $e';
    }
  }

  // Get trip details
  Future<Trip> getTripById(String tripId) async {
    try {
      final response = await _apiService.get('${AppConstants.getTripsEndpoint}/$tripId');
      return Trip.fromJson(response['trip']);
    } catch (e) {
      throw 'Failed to fetch trip: $e';
    }
  }

  // Create new trip
  Future<Trip> createTrip({
    required String destination,
    required String purpose,
    required DateTime startDate,
    required DateTime endDate,
    required double budget,
    List<String>? travelers,
  }) async {
    try {
      final response = await _apiService.post(
        AppConstants.createTripEndpoint,
        {
          'destination': destination,
          'purpose': purpose,
          'startDate': startDate.toIso8601String(),
          'endDate': endDate.toIso8601String(),
          'budget': budget,
          'travelers': travelers ?? [],
        },
      );
      return Trip.fromJson(response['trip']);
    } catch (e) {
      throw 'Failed to create trip: $e';
    }
  }

  // Update trip
  Future<Trip> updateTrip(String tripId, Map<String, dynamic> updates) async {
    try {
      final response = await _apiService.put(
        '${AppConstants.getTripsEndpoint}/$tripId',
        updates,
      );
      return Trip.fromJson(response['trip']);
    } catch (e) {
      throw 'Failed to update trip: $e';
    }
  }

  // Delete trip
  Future<void> deleteTrip(String tripId) async {
    try {
      await _apiService.delete('${AppConstants.getTripsEndpoint}/$tripId');
    } catch (e) {
      throw 'Failed to delete trip: $e';
    }
  }

  // Get trip expenses
  Future<List<Expense>> getTripExpenses(String tripId) async {
    try {
      final response = await _apiService.get(
        '${AppConstants.getTripsEndpoint}/$tripId/expenses',
      );
      final List<dynamic> expenses = response['expenses'] ?? [];
      return expenses.map((expense) => Expense.fromJson(expense as Map<String, dynamic>)).toList();
    } catch (e) {
      throw 'Failed to fetch trip expenses: $e';
    }
  }
}
