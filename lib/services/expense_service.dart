import '../models/expense.dart';
import '../config/constants.dart';
import 'api_service.dart';

class ExpenseService {
  final ApiService _apiService = ApiService();
  static final ExpenseService _instance = ExpenseService._internal();

  factory ExpenseService() {
    return _instance;
  }

  ExpenseService._internal();

  // Get all expenses for current user
  Future<List<Expense>> getExpenses() async {
    try {
      final response = await _apiService.get(AppConstants.getExpensesEndpoint);
      final List<dynamic> expenses = response['expenses'] ?? [];
      return expenses.map((expense) => Expense.fromJson(expense as Map<String, dynamic>)).toList();
    } catch (e) {
      throw 'Failed to fetch expenses: $e';
    }
  }

  // Get expense details
  Future<Expense> getExpenseById(String expenseId) async {
    try {
      final response = await _apiService.get('${AppConstants.getExpensesEndpoint}/$expenseId');
      return Expense.fromJson(response['expense']);
    } catch (e) {
      throw 'Failed to fetch expense: $e';
    }
  }

  // Create new expense
  Future<Expense> createExpense({
    required String tripId,
    required String category,
    required String description,
    required double amount,
    required String currency,
    String? receiptUrl,
    String? notes,
  }) async {
    try {
      final response = await _apiService.post(
        AppConstants.createExpenseEndpoint,
        {
          'tripId': tripId,
          'category': category,
          'description': description,
          'amount': amount,
          'currency': currency,
          'receiptUrl': receiptUrl,
          'notes': notes,
          'date': DateTime.now().toIso8601String(),
        },
      );
      return Expense.fromJson(response['expense']);
    } catch (e) {
      throw 'Failed to create expense: $e';
    }
  }

  // Update expense
  Future<Expense> updateExpense(String expenseId, Map<String, dynamic> updates) async {
    try {
      final response = await _apiService.put(
        '${AppConstants.getExpensesEndpoint}/$expenseId',
        updates,
      );
      return Expense.fromJson(response['expense']);
    } catch (e) {
      throw 'Failed to update expense: $e';
    }
  }

  // Delete expense
  Future<void> deleteExpense(String expenseId) async {
    try {
      await _apiService.delete('${AppConstants.getExpensesEndpoint}/$expenseId');
    } catch (e) {
      throw 'Failed to delete expense: $e';
    }
  }

  // Get expenses by category
  Future<Map<String, double>> getExpensesByCategory(String tripId) async {
    try {
      final expenses = await _apiService.get(
        '${AppConstants.getExpensesEndpoint}?tripId=$tripId&groupBy=category',
      );
      final Map<String, double> result = {};
      (expenses['expenses'] as List).forEach((exp) {
        final category = exp['category'];
        final amount = (exp['total'] as num).toDouble();
        result[category] = amount;
      });
      return result;
    } catch (e) {
      throw 'Failed to fetch expenses by category: $e';
    }
  }

  // Approve expense (admin only)
  Future<Expense> approveExpense(String expenseId) async {
    try {
      final response = await _apiService.put(
        '${AppConstants.getExpensesEndpoint}/$expenseId/approve',
        {'status': 'Approved'},
      );
      return Expense.fromJson(response['expense']);
    } catch (e) {
      throw 'Failed to approve expense: $e';
    }
  }

  // Reject expense (admin only)
  Future<Expense> rejectExpense(String expenseId, String reason) async {
    try {
      final response = await _apiService.put(
        '${AppConstants.getExpensesEndpoint}/$expenseId/reject',
        {'status': 'Rejected', 'reason': reason},
      );
      return Expense.fromJson(response['expense']);
    } catch (e) {
      throw 'Failed to reject expense: $e';
    }
  }
}
