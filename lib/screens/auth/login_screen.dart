import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navan_business_travel/screens/home/home_screen.dart';
import '../../controllers/user_controller.dart';
import '../../config/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final UserController userController = Get.put(UserController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;
  bool isSignup = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    departmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    '✈️',
                    style: TextStyle(fontSize: 50),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Navan',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Business Travel & Expense Management',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              // Login/Signup Form
              if (isSignup) ..._buildSignupForm(context),
              if (!isSignup) ..._buildLoginForm(context),
              const SizedBox(height: 20),
              // Toggle signup/login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isSignup ? 'Already have an account? ' : 'Don\'t have an account? ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  GestureDetector(
                    onTap: () => setState(() => isSignup = !isSignup),
                    child: Text(
                      isSignup ? 'Login' : 'Sign up',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildLoginForm(BuildContext context) {
    return [
      TextField(
        controller: emailController,
        decoration: InputDecoration(
          hintText: 'Email',
          prefixIcon: const Icon(Icons.email),
        ),
        keyboardType: TextInputType.emailAddress,
      ),
      const SizedBox(height: 16),
      TextField(
        controller: passwordController,
        decoration: InputDecoration(
          hintText: 'Password',
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: GestureDetector(
            onTap: () => setState(() => obscurePassword = !obscurePassword),
            child: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility),
          ),
        ),
        obscureText: obscurePassword,
      ),
      const SizedBox(height: 24),
      Obx(
        () => SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: userController.isLoading.value
                ? null
                : () async {
                    final success = await userController.login(
                      emailController.text,
                      passwordController.text,
                    );
                    if (success) {
                      Get.offAll(() => const HomeScreen());
                    } else {
                      Get.snackbar(
                        'Login Failed',
                        userController.error.value,
                        backgroundColor: AppTheme.errorColor,
                        colorText: Colors.white,
                      );
                    }
                  },
            child: userController.isLoading.value
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text('Login'),
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildSignupForm(BuildContext context) {
    return [
      TextField(
        controller: nameController,
        decoration: InputDecoration(
          hintText: 'Full Name',
          prefixIcon: const Icon(Icons.person),
        ),
      ),
      const SizedBox(height: 16),
      TextField(
        controller: emailController,
        decoration: InputDecoration(
          hintText: 'Email',
          prefixIcon: const Icon(Icons.email),
        ),
        keyboardType: TextInputType.emailAddress,
      ),
      const SizedBox(height: 16),
      TextField(
        controller: departmentController,
        decoration: InputDecoration(
          hintText: 'Department',
          prefixIcon: const Icon(Icons.business),
        ),
      ),
      const SizedBox(height: 16),
      TextField(
        controller: passwordController,
        decoration: InputDecoration(
          hintText: 'Password',
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: GestureDetector(
            onTap: () => setState(() => obscurePassword = !obscurePassword),
            child: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility),
          ),
        ),
        obscureText: obscurePassword,
      ),
      const SizedBox(height: 24),
      Obx(
        () => SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: userController.isLoading.value
                ? null
                : () async {
                    final success = await userController.signup(
                      nameController.text,
                      emailController.text,
                      passwordController.text,
                      departmentController.text,
                    );
                    if (success) {
                      Get.offAll(() => const HomeScreen());
                    } else {
                      Get.snackbar(
                        'Signup Failed',
                        userController.error.value,
                        backgroundColor: AppTheme.errorColor,
                        colorText: Colors.white,
                      );
                    }
                  },
            child: userController.isLoading.value
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text('Sign up'),
          ),
        ),
      ),
    ];
  }
}
