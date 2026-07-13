import 'package:get/get.dart';
import '../models/flight_booking.dart';
import '../models/hotel_booking.dart';
import '../services/mock_api_interceptor.dart';

class BookingController extends GetxController {
  final RxList<FlightBooking> flightBookings = <FlightBooking>[].obs;
  final RxList<HotelBooking> hotelBookings = <HotelBooking>[].obs;
  final Rx<FlightBooking?> selectedFlight = Rx<FlightBooking?>(null);
  final Rx<HotelBooking?> selectedHotel = Rx<HotelBooking?>(null);
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  // Get flight bookings for a trip
  Future<void> fetchFlightBookingsByTrip(String tripId) async {
    isLoading.value = true;
    error.value = '';

    try {
      final response = await MockApiInterceptor.getFlightBookingsByTrip(tripId);
      final List<dynamic> flights = response['flights'] ?? [];
      flightBookings.value = flights
          .map((flight) => FlightBooking.fromJson(flight as Map<String, dynamic>))
          .toList();
      isLoading.value = false;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
    }
  }

  // Get hotel bookings for a trip
  Future<void> fetchHotelBookingsByTrip(String tripId) async {
    isLoading.value = true;
    error.value = '';

    try {
      final response = await MockApiInterceptor.getHotelBookingsByTrip(tripId);
      final List<dynamic> hotels = response['hotels'] ?? [];
      hotelBookings.value = hotels
          .map((hotel) => HotelBooking.fromJson(hotel as Map<String, dynamic>))
          .toList();
      isLoading.value = false;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
    }
  }

  // Create flight booking
  Future<bool> createFlightBooking({
    required String tripId,
    required String airline,
    required String flightNumber,
    required String departureAirport,
    required String arrivalAirport,
    required DateTime departureTime,
    required DateTime arrivalTime,
    required double price,
    String? currency,
    int? passengers,
    String? seatNumber,
    String? bookingReference,
  }) async {
    isLoading.value = true;
    error.value = '';

    try {
      final response = await MockApiInterceptor.createFlightBooking({
        'tripId': tripId,
        'airline': airline,
        'flightNumber': flightNumber,
        'departureAirport': departureAirport,
        'arrivalAirport': arrivalAirport,
        'departureTime': departureTime.toIso8601String(),
        'arrivalTime': arrivalTime.toIso8601String(),
        'price': price,
        'currency': currency ?? 'USD',
        'passengers': passengers ?? 1,
        'seatNumber': seatNumber,
        'bookingReference': bookingReference,
      });

      final newFlight = FlightBooking.fromJson(response['flight']);
      flightBookings.add(newFlight);
      isLoading.value = false;
      return true;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
      return false;
    }
  }

  // Update flight booking
  Future<bool> updateFlightBooking(
    String flightId, {
    required String tripId,
    String? airline,
    String? flightNumber,
    String? departureAirport,
    String? arrivalAirport,
    DateTime? departureTime,
    DateTime? arrivalTime,
    double? price,
    String? currency,
    int? passengers,
    String? seatNumber,
    String? bookingReference,
  }) async {
    isLoading.value = true;
    error.value = '';

    try {
      final updates = {
        'tripId': tripId,
        if (airline != null) 'airline': airline,
        if (flightNumber != null) 'flightNumber': flightNumber,
        if (departureAirport != null) 'departureAirport': departureAirport,
        if (arrivalAirport != null) 'arrivalAirport': arrivalAirport,
        if (departureTime != null) 'departureTime': departureTime.toIso8601String(),
        if (arrivalTime != null) 'arrivalTime': arrivalTime.toIso8601String(),
        if (price != null) 'price': price,
        if (currency != null) 'currency': currency,
        if (passengers != null) 'passengers': passengers,
        if (seatNumber != null) 'seatNumber': seatNumber,
        if (bookingReference != null) 'bookingReference': bookingReference,
      };

      final response = await MockApiInterceptor.updateFlightBooking(flightId, updates);
      final updatedFlight = FlightBooking.fromJson(response['flight']);

      final index = flightBookings.indexWhere((f) => f.id == flightId);
      if (index != -1) {
        flightBookings[index] = updatedFlight;
      }

      isLoading.value = false;
      return true;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
      return false;
    }
  }

  // Delete flight booking
  Future<bool> deleteFlightBooking(String flightId) async {
    isLoading.value = true;
    error.value = '';

    try {
      await MockApiInterceptor.deleteFlightBooking(flightId);
      flightBookings.removeWhere((f) => f.id == flightId);
      isLoading.value = false;
      return true;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
      return false;
    }
  }

  // Create hotel booking
  Future<bool> createHotelBooking({
    required String tripId,
    required String hotelName,
    required String location,
    required String address,
    required DateTime checkInDate,
    required DateTime checkOutDate,
    int? numberOfRooms,
    required double pricePerNight,
    String? currency,
    String? roomType,
    String? confirmationNumber,
    List<String>? amenities,
  }) async {
    isLoading.value = true;
    error.value = '';

    try {
      final response = await MockApiInterceptor.createHotelBooking({
        'tripId': tripId,
        'hotelName': hotelName,
        'location': location,
        'address': address,
        'checkInDate': checkInDate.toIso8601String(),
        'checkOutDate': checkOutDate.toIso8601String(),
        'numberOfRooms': numberOfRooms ?? 1,
        'pricePerNight': pricePerNight,
        'currency': currency ?? 'USD',
        'roomType': roomType,
        'confirmationNumber': confirmationNumber,
        'amenities': amenities,
      });

      final newHotel = HotelBooking.fromJson(response['hotel']);
      hotelBookings.add(newHotel);
      isLoading.value = false;
      return true;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
      return false;
    }
  }

  // Update hotel booking
  Future<bool> updateHotelBooking(
    String hotelId, {
    required String tripId,
    String? hotelName,
    String? location,
    String? address,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    int? numberOfRooms,
    double? pricePerNight,
    String? currency,
    String? roomType,
    String? confirmationNumber,
    List<String>? amenities,
  }) async {
    isLoading.value = true;
    error.value = '';

    try {
      final updates = {
        'tripId': tripId,
        if (hotelName != null) 'hotelName': hotelName,
        if (location != null) 'location': location,
        if (address != null) 'address': address,
        if (checkInDate != null) 'checkInDate': checkInDate.toIso8601String(),
        if (checkOutDate != null) 'checkOutDate': checkOutDate.toIso8601String(),
        if (numberOfRooms != null) 'numberOfRooms': numberOfRooms,
        if (pricePerNight != null) 'pricePerNight': pricePerNight,
        if (currency != null) 'currency': currency,
        if (roomType != null) 'roomType': roomType,
        if (confirmationNumber != null) 'confirmationNumber': confirmationNumber,
        if (amenities != null) 'amenities': amenities,
      };

      final response = await MockApiInterceptor.updateHotelBooking(hotelId, updates);
      final updatedHotel = HotelBooking.fromJson(response['hotel']);

      final index = hotelBookings.indexWhere((h) => h.id == hotelId);
      if (index != -1) {
        hotelBookings[index] = updatedHotel;
      }

      isLoading.value = false;
      return true;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
      return false;
    }
  }

  // Delete hotel booking
  Future<bool> deleteHotelBooking(String hotelId) async {
    isLoading.value = true;
    error.value = '';

    try {
      await MockApiInterceptor.deleteHotelBooking(hotelId);
      hotelBookings.removeWhere((h) => h.id == hotelId);
      isLoading.value = false;
      return true;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
      return false;
    }
  }

  // Calculate total booking cost
  double get totalBookingCost {
    double total = 0;
    for (var flight in flightBookings) {
      total += flight.price;
    }
    for (var hotel in hotelBookings) {
      total += hotel.totalPrice;
    }
    return total;
  }
}
