import 'package:flutter/material.dart';
import 'package:flutter_final_project_kintkin/Pages/home_screen.dart';
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
  // Authentication service layer instance
  final AuthService _authService = AuthService();

  final _ageController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose(){
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();


  }

// HANDLE REGISTER ///////////////////////////////

Future<void> _handleRegister() async {
    // 1. Basic Local Validation Checks
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.isEmpty ||
        _ageController.text.trim().isEmpty ||
        _phoneNumberController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all fields')),
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    // 2. Start Network Operation
    setState(() => _isLoading = true);

    try {
      // Run the dynamic authentication service request
      await _authService.registerWithEmailAndPassword(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        age: int.tryParse(_ageController.text.trim()) ?? 0,
        phoneNumber: _phoneNumberController.text,
      );

      // --- SUCCESS PATH ---

      // Always turn off loading first so the button goes back to normal if they return to this page
      if (mounted) {
        setState(() => _isLoading = false);
      }
      
    } catch (e) {
      // --- ERROR PATH ---
      if (!mounted) return;

      // Turn off loading because an error occurred
      setState(() => _isLoading = false);

      String errorMessage = "Registration failed. Please try again.";
      final errorString = e.toString();

      if (errorString.contains('email-already-in-use')) {
        errorMessage =
            "This email address is already in use by another account.";
      } else if (errorString.contains('weak-password')) {
        errorMessage = "The password provided is too weak.";
      } else if (errorString.contains('invalid-email')) {
        errorMessage = "The email address is badly formatted.";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  void _goToMain(){
     Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
    }

  void _goToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const AuthLogo(),
              const SizedBox(height: 28),
              Text('Create Account', style: AppTextStyles.heading),
              const SizedBox(height: 8),
              Text(
                'Sign up to get started. ',
                style: AppTextStyles.subtitle,
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 20),
              CustomTextField(label: 'Name', 
              hintText: 'Name', 
              icon: Icons.person_outline,
              controller: _nameController,
              keyboardType:TextInputType.name
              ) ,
            const SizedBox(height: 20,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: CustomTextField(
                label:'Age' ,
                hintText: 'age', 
                icon: Icons.numbers_outlined,
                controller: _ageController,
                keyboardType: TextInputType.number,
                ),
                ),
              const SizedBox(width:  5),
              Expanded(child: 
              CustomTextField(
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
              label:'Password' , 
              hintText: '.....', 
              icon: Icons.lock_outlined,
              controller: _passwordController,
              obscureText: true,
              ),
              const SizedBox(height: 20),
              CustomTextField(
              label:'Re-Enter Password' , 
              hintText: '.....', 
              icon: Icons.lock_outlined,
              controller: _confirmPasswordController,
              obscureText: true,
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                text: 'Sign Up',
                onPressed: () => _handleRegister(),
                isLoading: _isLoading,
                textColor: Colors.white,
              ),
              const SizedBox(height: 24),
              LoginText(onTap: _goToLogin)
            ],
          ),
        ),
        ),
    );
  }
}