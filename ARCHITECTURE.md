# Architecture Guide

## Overview

The Navan Business Travel app uses a clean architecture pattern with clear separation of concerns:

```
UI Layer (Screens) 
    ↓
State Management Layer (GetX Controllers)
    ↓
Business Logic Layer (Services)
    ↓
Data Layer (Models & API)
```

---

## Layer Breakdown

### 1. UI Layer (Screens)
**Location**: `lib/screens/`

**Responsibilities**:
- Display UI components
- Handle user interactions
- Update UI based on state changes
- Navigate between screens

**Example**:
```dart
class HomeScreen extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Reactive UI based on controller state
    });
  }
}
```

### 2. State Management Layer (Controllers)
**Location**: `lib/controllers/`

**Responsibilities**:
- Manage application state
- Coordinate between UI and services
- Handle business logic
- Provide reactive streams

**Example**:
```dart
class UserController extends GetxController {
  final Rx<User?> user = Rx<User?>(null);
  final RxBool isLoading = false.obs;
  
  Future<bool> login(String email, String password) async {
    isLoading.value = true;
    try {
      user.value = await _authService.login(email, password);
      return true;
    } finally {
      isLoading.value = false;
    }
  }
}
```

### 3. Business Logic Layer (Services)
**Location**: `lib/services/`

**Responsibilities**:
- Encapsulate business logic
- Handle API calls
- Process data transformations
- Manage external integrations

**Example**:
```dart
class AuthService {
  Future<User> login(String email, String password) async {
    final response = await _apiService.post(
      AppConstants.loginEndpoint,
      {'email': email, 'password': password},
    );
    
    if (response['token'] != null) {
      _apiService.setAuthToken(response['token']);
      return User.fromJson(response['user']);
    }
    throw 'Invalid credentials';
  }
}
```

### 4. Data Layer (Models & API)
**Location**: `lib/models/` and `lib/services/api_service.dart`

**Responsibilities**:
- Define data structures
- Handle serialization/deserialization
- Make HTTP requests
- Cache data

**Example**:
```dart
class User {
  final String id;
  final String name;
  final String email;
  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
```

---

## Data Flow

### Example: Fetching Trips

```
1. UI (TripsScreen)
   ↓
   Calls: tripController.fetchTrips()
   
2. Controller (TripController)
   ↓
   Sets: isLoading.value = true
   Calls: _travelService.getTrips()
   
3. Service (TravelService)
   ↓
   Calls: _apiService.get(endpoint)
   
4. API Service
   ↓
   Makes HTTP GET request
   Returns: List of trips
   
5. Service parses response
   ↓
   Returns: List<Trip>
   
6. Controller updates state
   ↓
   Sets: trips.value = result
   Sets: isLoading.value = false
   
7. UI rebuilds automatically
   ↓
   Displays: trips list
```

---

## Best Practices

### 1. Separation of Concerns
✅ Do:
```dart
// Service handles API call
class TravelService {
  Future<List<Trip>> getTrips() async {
    final response = await _apiService.get(endpoint);
    return response['trips'].map((t) => Trip.fromJson(t)).toList();
  }
}

// Controller manages state
class TripController extends GetxController {
  Future<void> fetchTrips() async {
    trips.value = await _travelService.getTrips();
  }
}

// UI displays data
class TripsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView(children: tripController.trips));
  }
}
```

❌ Don't:
```dart
// Don't make API calls from UI
class TripsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: http.get(...),  // ❌ API call in UI
      builder: (context, snapshot) => ...,
    );
  }
}
```

### 2. Error Handling
✅ Do:
```dart
Future<void> fetchTrips() async {
  try {
    isLoading.value = true;
    trips.value = await _travelService.getTrips();
  } catch (e) {
    error.value = e.toString();
    Get.snackbar('Error', error.value);
  } finally {
    isLoading.value = false;
  }
}
```

### 3. Reactive State Management
✅ Do:
```dart
// Use Obx for reactive rebuilds
Obx(() => Text(controller.user.value?.name ?? 'Guest'))

// Use GetBuilder for manual updates
GetBuilder<UserController>(
  builder: (controller) => Text(controller.user.value?.name ?? 'Guest'),
)
```

### 4. Dependency Injection
✅ Do:
```dart
// Initialize controllers at startup
final userController = Get.put(UserController());

// Access anywhere
UserController controller = Get.find<UserController>();
```

---

## Adding New Features

### Step 1: Create Model
```dart
// lib/models/transaction.dart
class Transaction {
  final String id;
  final double amount;
  final DateTime date;
  
  Transaction.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      amount = json['amount'],
      date = DateTime.parse(json['date']);
}
```

### Step 2: Create Service
```dart
// lib/services/transaction_service.dart
class TransactionService {
  final ApiService _apiService = ApiService();
  
  Future<List<Transaction>> getTransactions() async {
    final response = await _apiService.get('/transactions');
    return (response['transactions'] as List)
      .map((t) => Transaction.fromJson(t))
      .toList();
  }
}
```

### Step 3: Create Controller
```dart
// lib/controllers/transaction_controller.dart
class TransactionController extends GetxController {
  final TransactionService _service = TransactionService();
  
  final RxList<Transaction> transactions = <Transaction>[].obs;
  final RxBool isLoading = false.obs;
  
  Future<void> fetchTransactions() async {
    isLoading.value = true;
    try {
      transactions.value = await _service.getTransactions();
    } finally {
      isLoading.value = false;
    }
  }
}
```

### Step 4: Create Screen
```dart
// lib/screens/transactions_screen.dart
class TransactionsScreen extends StatefulWidget {
  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final controller = Get.put(TransactionController());
  
  @override
  void initState() {
    super.initState();
    controller.fetchTransactions();
  }
  
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: controller.transactions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('\$${controller.transactions[index].amount}'),
          );
        },
      ),
    );
  }
}
```

---

## Testing

### Unit Testing Services
```dart
test('AuthService.login returns user on success', () async {
  final result = await authService.login('test@test.com', 'password');
  expect(result.email, 'test@test.com');
});
```

### Widget Testing
```dart
testWidgets('LoginScreen displays login form', (tester) async {
  await tester.pumpWidget(const MyApp());
  expect(find.byType(TextField), findsWidgets);
});
```

---

## Performance Tips

1. **Lazy Load Data**: Only fetch data when needed
2. **Pagination**: Implement pagination for large lists
3. **Caching**: Cache API responses to reduce requests
4. **Image Optimization**: Use cached_network_image
5. **Code Splitting**: Separate features into modules

---

For more information, see the main README.md file.
