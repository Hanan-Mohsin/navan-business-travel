class AppConstants {
  // API Configuration
  static const String apiBaseUrl = 'https://api.navan.local';
  static const String apiVersion = 'v1';
  static const Duration apiTimeout = Duration(seconds: 30);

  // App Configuration
  static const String appName = 'Navan';
  static const String appVersion = '1.0.0';

  // API Endpoints
  static const String loginEndpoint = '/auth/login';
  static const String logoutEndpoint = '/auth/logout';
  static const String getUserEndpoint = '/user/profile';
  static const String getTripsEndpoint = '/trips';
  static const String createTripEndpoint = '/trips';
  static const String getExpensesEndpoint = '/expenses';
  static const String createExpenseEndpoint = '/expenses';
  static const String getCardsEndpoint = '/cards';
  static const String getAnalyticsEndpoint = '/analytics';

  // Categories for expenses
  static const List<String> expenseCategories = [
    'Flight',
    'Hotel',
    'Restaurant',
    'Transport',
    'Entertainment',
    'Shopping',
    'Other',
  ];

  // Trip status
  static const List<String> tripStatus = [
    'Upcoming',
    'In Progress',
    'Completed',
    'Cancelled',
  ];

  // Expense status
  static const List<String> expenseStatus = [
    'Pending',
    'Approved',
    'Rejected',
    'Reimbursed',
  ];
}
