import 'package:get/get.dart';
import '../models/trip.dart';
import '../services/travel_service.dart';

class TripController extends GetxController {
  final TravelService _travelService = TravelService();
  final RxList<Trip> trips = <Trip>[].obs;
  final Rx<Trip?> selectedTrip = Rx<Trip?>(null);
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  // Get all trips
  Future<void> fetchTrips() async {
    isLoading.value = true;
    error.value = '';

    try {
      trips.value = await _travelService.getTrips();
      isLoading.value = false;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
    }
  }

  // Get trip by ID
  Future<void> fetchTripById(String tripId) async {
    isLoading.value = true;
    error.value = '';

    try {
      selectedTrip.value = await _travelService.getTripById(tripId);
      isLoading.value = false;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
    }
  }

  // Create new trip
  Future<bool> createTrip({
    required String destination,
    required String purpose,
    required DateTime startDate,
    required DateTime endDate,
    required double budget,
    List<String>? travelers,
  }) async {
    isLoading.value = true;
    error.value = '';

    try {
      final newTrip = await _travelService.createTrip(
        destination: destination,
        purpose: purpose,
        startDate: startDate,
        endDate: endDate,
        budget: budget,
        travelers: travelers,
      );
      trips.add(newTrip);
      isLoading.value = false;
      return true;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
      return false;
    }
  }

  // Update trip
  Future<bool> updateTrip(String tripId, Map<String, dynamic> updates) async {
    isLoading.value = true;
    error.value = '';

    try {
      final updatedTrip = await _travelService.updateTrip(tripId, updates);
      final index = trips.indexWhere((trip) => trip.id == tripId);
      if (index != -1) {
        trips[index] = updatedTrip;
      }
      if (selectedTrip.value?.id == tripId) {
        selectedTrip.value = updatedTrip;
      }
      isLoading.value = false;
      return true;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
      return false;
    }
  }

  // Delete trip
  Future<bool> deleteTrip(String tripId) async {
    isLoading.value = true;
    error.value = '';

    try {
      await _travelService.deleteTrip(tripId);
      trips.removeWhere((trip) => trip.id == tripId);
      isLoading.value = false;
      return true;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
      return false;
    }
  }

  // Get upcoming trips
  List<Trip> get upcomingTrips {
    return trips.where((trip) => trip.status == 'Upcoming').toList();
  }

  // Get completed trips
  List<Trip> get completedTrips {
    return trips.where((trip) => trip.status == 'Completed').toList();
  }

  // Clear error
  void clearError() {
    error.value = '';
  }
}
