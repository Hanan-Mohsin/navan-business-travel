import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'config/theme.dart';
import 'controllers/user_controller.dart';
import 'screens/auth/login_screen.dart';
import 'screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Navan',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: GetBuilder<UserController>(
        init: UserController(),
        builder: (controller) {
          return Obx(() {
            return controller.isLoggedIn.value ? const HomeScreen() : const LoginScreen();
          });
        },
      ),
    );
  }
}
