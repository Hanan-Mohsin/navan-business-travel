import '../models/user.dart';
import '../models/trip.dart';
import '../models/expense.dart';
import '../models/card.dart';
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
}
