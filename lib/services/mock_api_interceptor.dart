import '../models/user.dart';
import '../models/trip.dart';
import '../models/expense.dart';
import '../models/card.dart';
import '../models/flight_booking.dart';
import '../models/hotel_booking.dart';
import '../utils/dummy_data.dart';

class MockApiInterceptor {
  static Future<Map<String, dynamic>> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    // Mock validation
    if (email == 'demo@company.com' && password == 'password123') {
      return {
        'success': true,
        'token': 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
        'user': DummyData.dummyUser.toJson(),
      };
    }

    throw 'Invalid email or password';
  }

  static Future<Map<String, dynamic>> signup(
    String name,
    String email,
    String password,
    String department,
  ) async {
    await Future.delayed(const Duration(seconds: 2));

    final newUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      department: department,
      role: 'Employee',
      isActive: true,
      createdAt: DateTime.now(),
    );

    return {
      'success': true,
      'token': 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
      'user': newUser.toJson(),
    };
  }

  static Future<Map<String, dynamic>> getUser() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return {
      'success': true,
      'user': DummyData.dummyUser.toJson(),
    };
  }

  static Future<Map<String, dynamic>> getTrips() async {
    await Future.delayed(const Duration(seconds: 1));

    return {
      'success': true,
      'trips': DummyData.dummyTrips.map((trip) => trip.toJson()).toList(),
    };
  }

  static Future<Map<String, dynamic>> getTripById(String tripId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final trip = DummyData.dummyTrips.firstWhere(
      (t) => t.id == tripId,
      orElse: () => throw 'Trip not found',
    );

    return {
      'success': true,
      'trip': trip.toJson(),
    };
  }

  static Future<Map<String, dynamic>> createTrip(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(seconds: 1));

    final newTrip = Trip(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: DummyData.dummyUser.id,
      destination: data['destination'],
      purpose: data['purpose'],
      startDate: DateTime.parse(data['startDate']),
      endDate: DateTime.parse(data['endDate']),
      status: 'Upcoming',
      budget: data['budget'],
      spent: 0,
      travelers: data['travelers'] ?? [],
      createdAt: DateTime.now(),
    );

    DummyData.dummyTrips.add(newTrip);

    return {
      'success': true,
      'trip': newTrip.toJson(),
    };
  }

  static Future<Map<String, dynamic>> getExpenses() async {
    await Future.delayed(const Duration(seconds: 1));

    return {
      'success': true,
      'expenses': DummyData.dummyExpenses.map((expense) => expense.toJson()).toList(),
    };
  }

  static Future<Map<String, dynamic>> getExpenseById(String expenseId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final expense = DummyData.dummyExpenses.firstWhere(
      (e) => e.id == expenseId,
      orElse: () => throw 'Expense not found',
    );

    return {
      'success': true,
      'expense': expense.toJson(),
    };
  }

  static Future<Map<String, dynamic>> createExpense(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(seconds: 1));

    final newExpense = Expense(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: DummyData.dummyUser.id,
      tripId: data['tripId'],
      category: data['category'],
      description: data['description'],
      amount: data['amount'],
      currency: data['currency'] ?? 'USD',
      status: 'Pending',
      receiptUrl: data['receiptUrl'],
      notes: data['notes'],
      date: DateTime.parse(data['date']),
      createdAt: DateTime.now(),
    );

    DummyData.dummyExpenses.add(newExpense);

    return {
      'success': true,
      'expense': newExpense.toJson(),
    };
  }

  static Future<Map<String, dynamic>> getCards() async {
    await Future.delayed(const Duration(seconds: 1));

    return {
      'success': true,
      'cards': DummyData.dummyCards.map((card) => card.toJson()).toList(),
    };
  }

  static Future<Map<String, dynamic>> getCardById(String cardId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final card = DummyData.dummyCards.firstWhere(
      (c) => c.id == cardId,
      orElse: () => throw 'Card not found',
    );

    return {
      'success': true,
      'card': card.toJson(),
    };
  }

  // Analytics: Spending Summary
  static Future<Map<String, dynamic>> getSpendingSummary() async {
    await Future.delayed(const Duration(seconds: 1));

    final totalSpent = DummyData.dummyExpenses.fold<double>(
      0.0,
      (sum, expense) => sum + expense.amount,
    );

    final pendingExpenses = DummyData.dummyExpenses
        .where((e) => e.status == 'Pending')
        .fold<double>(0.0, (sum, e) => sum + e.amount);

    final approvedExpenses = DummyData.dummyExpenses
        .where((e) => e.status == 'Approved')
        .fold<double>(0.0, (sum, e) => sum + e.amount);

    return {
      'success': true,
      'summary': {
        'totalSpent': totalSpent,
        'monthlyBudget': 5000.0,
        'remainingBudget': 5000.0 - totalSpent,
        'pendingExpenses': pendingExpenses,
        'approvedExpenses': approvedExpenses,
        'expenseCount': DummyData.dummyExpenses.length,
        'averageExpense': totalSpent / (DummyData.dummyExpenses.isEmpty ? 1 : DummyData.dummyExpenses.length),
      },
    };
  }

  // Analytics: Spending by Category
  static Future<Map<String, dynamic>> getSpendingByCategory() async {
    await Future.delayed(const Duration(seconds: 1));

    final categoryMap = <String, double>{};

    for (var expense in DummyData.dummyExpenses) {
      categoryMap[expense.category] = (categoryMap[expense.category] ?? 0) + expense.amount;
    }

    final data = categoryMap.entries
        .map((e) => {'category': e.key, 'total': e.value})
        .toList();

    return {
      'success': true,
      'data': data,
    };
  }

  // Analytics: Spending by Month
  static Future<Map<String, dynamic>> getSpendingByMonth(int year) async {
    await Future.delayed(const Duration(seconds: 1));

    final monthlyMap = <int, double>{};

    for (var expense in DummyData.dummyExpenses) {
      if (expense.date.year == year) {
        final month = expense.date.month;
        monthlyMap[month] = (monthlyMap[month] ?? 0) + expense.amount;
      }
    }

    final monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    final data = monthlyMap.entries
        .map((e) => {'month': monthNames[e.key - 1], 'total': e.value})
        .toList();

    return {
      'success': true,
      'data': data,
    };
  }

  // Analytics: Policy Violations
  static Future<Map<String, dynamic>> getPolicyViolations() async {
    await Future.delayed(const Duration(seconds: 1));

    // Mock violations based on expense data
    final violations = <Map<String, dynamic>>[];

    for (var expense in DummyData.dummyExpenses) {
      // Simulate some violations
      if (expense.amount > 500) {
        violations.add({
          'id': expense.id,
          'type': 'Amount Exceeded',
          'description': 'Expense amount exceeds daily limit',
          'expenseId': expense.id,
          'amount': expense.amount,
          'limit': 500.0,
          'severity': 'High',
          'date': expense.date.toIso8601String(),
        });
      }

      if (expense.category == 'Entertainment' && expense.amount > 100) {
        violations.add({
          'id': '${expense.id}_cat',
          'type': 'Category Limit',
          'description': 'Entertainment expenses exceed weekly allowance',
          'expenseId': expense.id,
          'amount': expense.amount,
          'limit': 100.0,
          'severity': 'Medium',
          'date': expense.date.toIso8601String(),
        });
      }
    }

    return {
      'success': true,
      'violations': violations,
    };
  }

  // Flight Bookings
  static Future<Map<String, dynamic>> getFlightBookingsByTrip(String tripId) async {
    await Future.delayed(const Duration(seconds: 1));

    final flightBookings = <FlightBooking>[
      FlightBooking(
        id: 'flight_1',
        tripId: tripId,
        userId: DummyData.dummyUser.id,
        airline: 'United Airlines',
        flightNumber: 'UA456',
        departureAirport: 'SFO',
        arrivalAirport: 'LAX',
        departureTime: DateTime.now().add(const Duration(days: 5)),
        arrivalTime: DateTime.now().add(const Duration(days: 5, hours: 1)),
        price: 350.0,
        currency: 'USD',
        passengers: 1,
        seatNumber: '12A',
        bookingReference: 'FLIGHT123',
        status: 'Confirmed',
        createdAt: DateTime.now(),
      ),
    ];

    return {
      'success': true,
      'flights': flightBookings.map((f) => f.toJson()).toList(),
    };
  }

  static Future<Map<String, dynamic>> createFlightBooking(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(seconds: 1));

    final newFlight = FlightBooking(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      tripId: data['tripId'],
      userId: DummyData.dummyUser.id,
      airline: data['airline'],
      flightNumber: data['flightNumber'],
      departureAirport: data['departureAirport'],
      arrivalAirport: data['arrivalAirport'],
      departureTime: DateTime.parse(data['departureTime']),
      arrivalTime: DateTime.parse(data['arrivalTime']),
      price: data['price'],
      currency: data['currency'] ?? 'USD',
      passengers: data['passengers'] ?? 1,
      seatNumber: data['seatNumber'],
      bookingReference: data['bookingReference'],
      status: 'Confirmed',
      createdAt: DateTime.now(),
    );

    return {
      'success': true,
      'flight': newFlight.toJson(),
    };
  }

  static Future<Map<String, dynamic>> updateFlightBooking(String flightId, Map<String, dynamic> data) async {
    await Future.delayed(const Duration(seconds: 1));

    final updatedFlight = FlightBooking(
      id: flightId,
      tripId: data['tripId'],
      userId: DummyData.dummyUser.id,
      airline: data['airline'] ?? 'United Airlines',
      flightNumber: data['flightNumber'] ?? 'UA456',
      departureAirport: data['departureAirport'] ?? 'SFO',
      arrivalAirport: data['arrivalAirport'] ?? 'LAX',
      departureTime: data['departureTime'] != null ? DateTime.parse(data['departureTime']) : DateTime.now(),
      arrivalTime: data['arrivalTime'] != null ? DateTime.parse(data['arrivalTime']) : DateTime.now(),
      price: data['price'] ?? 350.0,
      currency: data['currency'] ?? 'USD',
      passengers: data['passengers'] ?? 1,
      seatNumber: data['seatNumber'],
      bookingReference: data['bookingReference'],
      status: 'Confirmed',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    return {
      'success': true,
      'flight': updatedFlight.toJson(),
    };
  }

  static Future<Map<String, dynamic>> deleteFlightBooking(String flightId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return {
      'success': true,
      'message': 'Flight booking cancelled',
    };
  }

  // Hotel Bookings
  static Future<Map<String, dynamic>> getHotelBookingsByTrip(String tripId) async {
    await Future.delayed(const Duration(seconds: 1));

    final hotelBookings = <HotelBooking>[
      HotelBooking(
        id: 'hotel_1',
        tripId: tripId,
        userId: DummyData.dummyUser.id,
        hotelName: 'Luxury Hotel Downtown',
        location: 'Downtown LA',
        address: '123 Main St, Los Angeles, CA 90001',
        checkInDate: DateTime.now().add(const Duration(days: 5)),
        checkOutDate: DateTime.now().add(const Duration(days: 8)),
        numberOfRooms: 1,
        numberOfNights: 3,
        pricePerNight: 250.0,
        totalPrice: 750.0,
        currency: 'USD',
        roomType: 'Deluxe Suite',
        confirmationNumber: 'HOTEL123',
        amenities: ['WiFi', 'Gym', 'Pool', 'Restaurant'],
        status: 'Confirmed',
        createdAt: DateTime.now(),
      ),
    ];

    return {
      'success': true,
      'hotels': hotelBookings.map((h) => h.toJson()).toList(),
    };
  }

  static Future<Map<String, dynamic>> createHotelBooking(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(seconds: 1));

    final checkIn = DateTime.parse(data['checkInDate']);
    final checkOut = DateTime.parse(data['checkOutDate']);
    final nights = checkOut.difference(checkIn).inDays;
    final totalPrice = nights * (data['pricePerNight'] as num).toDouble();

    final newHotel = HotelBooking(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      tripId: data['tripId'],
      userId: DummyData.dummyUser.id,
      hotelName: data['hotelName'],
      location: data['location'],
      address: data['address'],
      checkInDate: checkIn,
      checkOutDate: checkOut,
      numberOfRooms: data['numberOfRooms'] ?? 1,
      numberOfNights: nights,
      pricePerNight: (data['pricePerNight'] as num).toDouble(),
      totalPrice: totalPrice,
      currency: data['currency'] ?? 'USD',
      roomType: data['roomType'],
      confirmationNumber: data['confirmationNumber'],
      amenities: data['amenities'] != null ? List<String>.from(data['amenities']) : null,
      status: 'Confirmed',
      createdAt: DateTime.now(),
    );

    return {
      'success': true,
      'hotel': newHotel.toJson(),
    };
  }

  static Future<Map<String, dynamic>> updateHotelBooking(String hotelId, Map<String, dynamic> data) async {
    await Future.delayed(const Duration(seconds: 1));

    final checkIn = data['checkInDate'] != null ? DateTime.parse(data['checkInDate']) : DateTime.now();
    final checkOut = data['checkOutDate'] != null ? DateTime.parse(data['checkOutDate']) : DateTime.now();
    final nights = checkOut.difference(checkIn).inDays;
    final pricePerNight = (data['pricePerNight'] as num?)?.toDouble() ?? 250.0;
    final totalPrice = nights * pricePerNight;

    final updatedHotel = HotelBooking(
      id: hotelId,
      tripId: data['tripId'],
      userId: DummyData.dummyUser.id,
      hotelName: data['hotelName'] ?? 'Luxury Hotel Downtown',
      location: data['location'] ?? 'Downtown LA',
      address: data['address'] ?? '123 Main St, Los Angeles, CA 90001',
      checkInDate: checkIn,
      checkOutDate: checkOut,
      numberOfRooms: data['numberOfRooms'] ?? 1,
      numberOfNights: nights,
      pricePerNight: pricePerNight,
      totalPrice: totalPrice,
      currency: data['currency'] ?? 'USD',
      roomType: data['roomType'],
      confirmationNumber: data['confirmationNumber'],
      amenities: data['amenities'] != null ? List<String>.from(data['amenities']) : null,
      status: 'Confirmed',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    return {
      'success': true,
      'hotel': updatedHotel.toJson(),
    };
  }

  static Future<Map<String, dynamic>> deleteHotelBooking(String hotelId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return {
      'success': true,
      'message': 'Hotel booking cancelled',
    };
  }
}
