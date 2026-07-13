# Navan Business Travel & Expense Management App

A Flutter application for managing business travel and expenses, inspired by Navan's features.

## Features

✈️ **Travel Management**
- Book flights, hotels, trains, and cars
- View upcoming trips and itineraries
- Real-time trip status tracking

💰 **Expense Tracking**
- Log and categorize expenses
- Receipt capture and management
- Automated expense reporting

💳 **Corporate Cards**
- Virtual and physical card management
- Real-time transaction monitoring
- Spend analytics

📊 **Analytics & Reporting**
- Dashboard with spending overview
- Category-wise expense breakdown
- Monthly and yearly reports

📱 **Policy Compliance**
- Out-of-policy alerts
- Approval workflows
- Spend guardrails

## Project Structure

```
lib/
├── main.dart                 # Entry point
├── config/
│   ├── theme.dart           # App theming
│   └── constants.dart       # App constants
├── models/                  # Data models
│   ├── trip.dart
│   ├── expense.dart
│   ├── card.dart
│   └── user.dart
├── services/                # API & Business logic
│   ├── api_service.dart
│   ├── travel_service.dart
│   ├── expense_service.dart
│   └── auth_service.dart
├── providers/               # State management
│   ├── user_provider.dart
│   ├── trip_provider.dart
│   ├── expense_provider.dart
│   └── card_provider.dart
├── screens/                 # UI Screens
│   ├── auth/
│   ├── home/
│   ├── trips/
│   ├── expenses/
│   ├── cards/
│   ├── analytics/
│   └── profile/
└── widgets/                 # Reusable widgets
    ├── custom_app_bar.dart
    ├── expense_card.dart
    └── ...
```

## Getting Started

1. Clone the repository
2. Run `flutter pub get`
3. Run `flutter run` to start the app

## API Integration

Currently using placeholder API endpoints. Update `lib/config/constants.dart` with your API base URL:

```dart
const String API_BASE_URL = 'https://your-api.com';
```

## Dummy Data

The app uses dummy data for testing. Data models are in `lib/models/` and sample data generators are in `lib/services/`.

## Dependencies

- **provider**: State management
- **http**: API calls
- **fl_chart**: Data visualization
- **image_picker**: Receipt capture
- **intl**: Date/time formatting
