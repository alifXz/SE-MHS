import 'package:flutter/material.dart';
import 'package:flutter_final_project_kintkin/Pages/main_screen.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/auth_logo.dart';
import '../widgets/primary_button.dart';
import '../widgets/LoginText.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _authService = AuthService();

  final _ageController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    // Basic validation
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty ||
        _ageController.text.trim().isEmpty ||
        _phoneNumberController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill out all fields'),
        ),
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.signUp(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        age: int.parse(_ageController.text.trim()),
        phoneNumber: _phoneNumberController.text.trim(),
      );

      if (!mounted) return;

      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration successful!'),
        ),
      );

      _goToMain();

    } catch (e) {
      if (!mounted) return;

      setState(() => _isLoading = false);

      String errorMessage = 'Registration failed';

      final error = e.toString();

      // error validations
      if (error.contains('User already registered')) {
        errorMessage = 'Email is already registered';
      } else if (error.contains('Password should be at least')) {
        errorMessage = 'Password is too weak';
      } else if (error.contains('Invalid email')) {
        errorMessage = 'Invalid email format';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  void _goToMain() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const MainScreen(
          isNewRegistration: true,
        ),
      ),
    );
  }

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              const AuthLogo(),

              const SizedBox(height: 28),

              Text(
                'Create Account',
                style: AppTextStyles.heading,
              ),

              const SizedBox(height: 8),

              Text(
                'Sign up to get started.',
                style: AppTextStyles.subtitle,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              CustomTextField(
                label: 'Name',
                hintText: 'Name',
                icon: Icons.person_outline,
                controller: _nameController,
                keyboardType: TextInputType.name,
              ),

              const SizedBox(height: 20),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: 'Age',
                      hintText: 'Age',
                      icon: Icons.numbers_outlined,
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                    ),
                  ),

                  const SizedBox(width: 5),

                  Expanded(
                    child: CustomTextField(
                      label: 'Phone Number',
                      hintText: '+62 812 9938 9987',
                      icon: Icons.phone_android_outlined,
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              CustomTextField(
                label: 'Email Address',
                hintText: 'aaa@gmail.com',
                icon: Icons.email_outlined,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 20),

              CustomTextField(
                label: 'Password',
                hintText: '.....',
                icon: Icons.lock_outlined,
                controller: _passwordController,
                obscureText: true,
              ),

              const SizedBox(height: 20),

              CustomTextField(
                label: 'Re-Enter Password',
                hintText: '.....',
                icon: Icons.lock_outlined,
                controller: _confirmPasswordController,
                obscureText: true,
              ),

              const SizedBox(height: 32),

              PrimaryButton(
                text: 'Sign Up',
                onPressed: _handleRegister,
                isLoading: _isLoading,
                textColor: Colors.white,
              ),

              const SizedBox(height: 24),

              LoginText(
                onTap: _goToLogin,
              ),
            ],
          ),
        ),
      ),
    );
  }
}