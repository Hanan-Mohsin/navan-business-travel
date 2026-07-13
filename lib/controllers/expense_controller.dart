import 'package:get/get.dart';
import '../models/expense.dart';
import '../services/expense_service.dart';

class ExpenseController extends GetxController {
  final ExpenseService _expenseService = ExpenseService();
  final RxList<Expense> expenses = <Expense>[].obs;
  final Rx<Expense?> selectedExpense = Rx<Expense?>(null);
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxMap<String, double> expensesByCategory = <String, double>{}.obs;

  // Get all expenses
  Future<void> fetchExpenses() async {
    isLoading.value = true;
    error.value = '';

    try {
      expenses.value = await _expenseService.getExpenses();
      isLoading.value = false;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
    }
  }

  // Get expense by ID
  Future<void> fetchExpenseById(String expenseId) async {
    isLoading.value = true;
    error.value = '';

    try {
      selectedExpense.value = await _expenseService.getExpenseById(expenseId);
      isLoading.value = false;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
    }
  }

  // Create new expense
  Future<bool> createExpense({
    required String tripId,
    required String category,
    required String description,
    required double amount,
    required String currency,
    String? receiptUrl,
    String? notes,
  }) async {
    isLoading.value = true;
    error.value = '';

    try {
      final newExpense = await _expenseService.createExpense(
        tripId: tripId,
        category: category,
        description: description,
        amount: amount,
        currency: currency,
        receiptUrl: receiptUrl,
        notes: notes,
      );
      expenses.add(newExpense);
      isLoading.value = false;
      return true;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
      return false;
    }
  }

  // Update expense
  Future<bool> updateExpense(String expenseId, Map<String, dynamic> updates) async {
    isLoading.value = true;
    error.value = '';

    try {
      final updatedExpense = await _expenseService.updateExpense(expenseId, updates);
      final index = expenses.indexWhere((expense) => expense.id == expenseId);
      if (index != -1) {
        expenses[index] = updatedExpense;
      }
      if (selectedExpense.value?.id == expenseId) {
        selectedExpense.value = updatedExpense;
      }
      isLoading.value = false;
      return true;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
      return false;
    }
  }

  // Delete expense
  Future<bool> deleteExpense(String expenseId) async {
    isLoading.value = true;
    error.value = '';

    try {
      await _expenseService.deleteExpense(expenseId);
      expenses.removeWhere((expense) => expense.id == expenseId);
      isLoading.value = false;
      return true;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
      return false;
    }
  }

  // Get expenses by category
  Future<void> fetchExpensesByCategory(String tripId) async {
    isLoading.value = true;
    error.value = '';

    try {
      expensesByCategory.value = await _expenseService.getExpensesByCategory(tripId);
      isLoading.value = false;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
    }
  }

  // Get pending expenses
  List<Expense> get pendingExpenses {
    return expenses.where((expense) => expense.status == 'Pending').toList();
  }

  // Get approved expenses
  List<Expense> get approvedExpenses {
    return expenses.where((expense) => expense.status == 'Approved').toList();
  }

  // Get total expenses
  double get totalExpenses {
    return expenses.fold(0.0, (sum, expense) => sum + expense.amount);
  }

  // Approve expense
  Future<bool> approveExpense(String expenseId) async {
    isLoading.value = true;
    error.value = '';

    try {
      final approvedExpense = await _expenseService.approveExpense(expenseId);
      final index = expenses.indexWhere((expense) => expense.id == expenseId);
      if (index != -1) {
        expenses[index] = approvedExpense;
      }
      isLoading.value = false;
      return true;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
      return false;
    }
  }

  // Reject expense
  Future<bool> rejectExpense(String expenseId, String reason) async {
    isLoading.value = true;
    error.value = '';

    try {
      final rejectedExpense = await _expenseService.rejectExpense(expenseId, reason);
      final index = expenses.indexWhere((expense) => expense.id == expenseId);
      if (index != -1) {
        expenses[index] = rejectedExpense;
      }
      isLoading.value = false;
      return true;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
      return false;
    }
  }

  // Clear error
  void clearError() {
    error.value = '';
  }
}
