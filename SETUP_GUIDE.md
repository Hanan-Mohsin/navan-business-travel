# Navan Business Travel & Expense Management App

## 📱 Flutter Application

A modern Flutter app for managing business travel and expenses, inspired by Navan's comprehensive features.

---

## 🚀 Quick Start

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio or Xcode
- An IDE (VS Code, Android Studio, or IntelliJ)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Hanan-Mohsin/navan-business-travel.git
   cd navan-business-travel
   ```

2. **Get dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

---

## 🎯 Key Features

### ✈️ Travel Management
- **Book Trips**: Create and manage business trips
- **Trip Tracking**: Monitor trip status and timeline
- **Budget Monitoring**: Track spending against budget
- **Itinerary Management**: View trip details and attendees

### 💰 Expense Tracking
- **Quick Expense Logging**: Add expenses on-the-go
- **Receipt Capture**: Take photos of receipts
- **Categorization**: Auto-categorize by type (Flight, Hotel, Restaurant, etc.)
- **Approval Workflow**: Track expense approval status
- **Reimbursement**: Monitor reimbursement status

### 💳 Corporate Card Management
- **Card Overview**: View all corporate cards
- **Spend Limits**: Monitor spending against limits
- **Real-time Balance**: Check available balance
- **Card Controls**: Lock/unlock cards instantly
- **Transaction History**: View detailed transaction logs

### 📊 Analytics & Reporting
- **Spending Dashboard**: Visual overview of spending
- **Category Breakdown**: See spending by category
- **Monthly Trends**: Track spending patterns
- **Policy Compliance**: Monitor policy violations
- **Budget Forecasting**: Predict future spending

### 🔐 Policy Compliance
- **Automated Alerts**: Out-of-policy notifications
- **Approval Process**: Multi-level approvals
- **Audit Trail**: Complete transaction history
- **Compliance Reports**: Generate compliance reports

---

## 📁 Project Structure

```
lib/
├── main.dart                          # App entry point
├── config/
│   ├── theme.dart                    # App theming
│   └── constants.dart                # App constants
├── models/                           # Data models
│   ├── user.dart
│   ├── trip.dart
│   ├── expense.dart
│   └── card.dart
├── services/                         # Business logic
│   ├── api_service.dart
│   ├── auth_service.dart
│   ├── travel_service.dart
│   ├── expense_service.dart
│   ├── card_service.dart
│   ├── analytics_service.dart
│   └── mock_api_interceptor.dart
├── controllers/                      # GetX State Management
│   ├── user_controller.dart
│   ├── trip_controller.dart
│   ├── expense_controller.dart
│   └── card_controller.dart
├── screens/                          # UI Screens
│   ├── auth/
│   │   └── login_screen.dart
│   ├── home/
│   │   └── home_screen.dart
│   ├── trips/
│   │   └── trips_screen.dart
│   ├── expenses/
│   │   └── expenses_screen.dart
│   ├── cards/
│   │   └── cards_screen.dart
│   ├── analytics/
│   │   └── analytics_screen.dart
│   └── profile/
│       └── profile_screen.dart
├── widgets/                          # Reusable components
│   ├── custom_app_bar.dart
│   ├── expense_card.dart
│   ├── loading_widget.dart
│   ├── empty_state_widget.dart
│   └── status_badge.dart
├── utils/                            # Utility functions
│   ├── dummy_data.dart
│   ├── datetime_utils.dart
│   ├── currency_utils.dart
│   └── validation_utils.dart
└── assets/                           # Images, fonts, etc.
```

---

## 🔐 Demo Credentials

**For testing the app with mock data:**
- **Email**: `demo@company.com`
- **Password**: `password123`

> Note: Passwords are not validated in the mock API. You can use any credentials for signup.

---

## 🛠 Technology Stack

### Frontend
- **Flutter**: UI framework
- **Dart**: Programming language
- **GetX**: State management
- **fl_chart**: Data visualization

### Architecture
- **MVVM Pattern**: Model-View-ViewModel
- **Service Layer**: Centralized API calls
- **Controller Layer**: Business logic with GetX
- **Widget Layer**: Reusable UI components

### Dependencies
```yaml
get: ^4.6.5              # State management
http: ^1.1.0             # API calls
intl: ^0.19.0            # Internationalization
fl_chart: ^0.64.0        # Charts & graphs
image_picker: ^1.0.0     # Photo picking
cached_network_image: ^3.3.0  # Image caching
connectivity_plus: ^5.0.0     # Network connectivity
uuid: ^4.0.0             # UUID generation
```

---

## 📡 API Integration

### Mock API for Development
The app uses `MockApiInterceptor` for development and testing. It provides realistic delays and dummy data.

### Connecting to Real Backend

1. Update API base URL in `lib/config/constants.dart`:
   ```dart
   static const String apiBaseUrl = 'https://your-api.com';
   ```

2. Update endpoints as needed:
   ```dart
   static const String loginEndpoint = '/auth/login';
   static const String getTripsEndpoint = '/trips';
   // ... other endpoints
   ```

3. The `ApiService` will handle authentication headers and error handling automatically.

---

## 🎨 Theming

The app includes a comprehensive theme system in `lib/config/theme.dart`:

- **Primary Color**: #2E5090 (Professional Blue)
- **Secondary Color**: #00B4D8 (Sky Blue)
- **Success Color**: #2ECC71 (Green)
- **Warning Color**: #F39C12 (Orange)
- **Error Color**: #E74C3C (Red)

Customize colors by modifying the theme configuration.

---

## 🚀 Building for Production

### Android
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

---

## 📝 State Management with GetX

### Using Controllers

```dart
// Initialize controller
final controller = Get.put(UserController());

// Use reactive variables
Obx(() => Text(controller.user.value?.name ?? 'Guest'))

// Trigger actions
await controller.login(email, password);
```

### Available Controllers
- `UserController`: Authentication & user data
- `TripController`: Trip management
- `ExpenseController`: Expense management
- `CardController`: Corporate card management

---

## 🧪 Testing with Dummy Data

The app includes comprehensive dummy data for all entities:

```dart
// Access dummy data
DummyData.dummyUser          // Sample user
DummyData.dummyTrips         // Sample trips
DummyData.dummyExpenses      // Sample expenses
DummyData.dummyCards         // Sample cards
```

---

## 🎯 Development Workflow

1. **Feature Development**
   - Create model in `lib/models/`
   - Create service in `lib/services/`
   - Create controller in `lib/controllers/`
   - Build UI screen in `lib/screens/`

2. **Testing**
   - Use mock data for UI testing
   - Test with dummy API responses
   - Verify business logic in services

3. **Integration**
   - Connect to real API endpoints
   - Update authentication flow
   - Test error handling

---

## 🐛 Troubleshooting

### App won't run
- Run `flutter clean` and `flutter pub get`
- Ensure Flutter SDK is up to date: `flutter upgrade`

### API errors
- Check internet connection
- Verify API endpoint in constants
- Check authentication token validity

### State management issues
- Ensure controllers are properly initialized with `Get.put()`
- Use `Obx()` for reactive widgets
- Check for circular dependencies

---

## 📚 Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [GetX Documentation](https://github.com/jonataslaw/getx)
- [Dart Documentation](https://dart.dev/guides)
- [Material Design](https://material.io/design)

---

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## 👤 Author

**Hanan Mohsin**
- GitHub: [@Hanan-Mohsin](https://github.com/Hanan-Mohsin)

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

---

## 📞 Support

For issues and questions, please open an issue on the GitHub repository.

---

**Happy coding! 🚀**
