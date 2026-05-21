import 'package:flutter/material.dart';
import 'package:flutter_final_project_kintkin/Pages/main_screen.dart';
import 'package:flutter_final_project_kintkin/pages/register_screen.dart';
import 'package:flutter_final_project_kintkin/services/auth_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/auth_logo.dart';
import '../widgets/primary_button.dart';
import '../widgets/LoginText.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _authService = AuthService();
  
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
 
 
  
  bool _isLoading = false;

  @override
  void dispose(){
   
    _emailController.dispose();
    
    _passwordController.dispose();
    
    super.dispose();


  }

  Future<void> _handleLogin() async {

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }
    
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    setState(() => _isLoading = false); 

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Welcome back!')),
    );

    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;

    _goToHome();
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
              const SizedBox(height: 28),
              const AuthLogo(),
              const SizedBox(height: 28),
              Text('Welcome Back!', style: AppTextStyles.heading),
              const SizedBox(height: 8),
              Text(
                'Log in to continue to your account.',
                style: AppTextStyles.subtitle,
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 32),
              CustomTextField(
                label: 'Email Address',
                hintText: 'aaa@gmail.com',
                icon: Icons.email_outlined,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              
              const SizedBox(height: 32),
              CustomTextField(
              label:'Password' , 
              hintText: '.....', 
              icon: Icons.lock_outlined,
              controller: _passwordController,
              obscureText: true,
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                text: 'Login',
                onPressed: _handleLogin,
                isLoading: _isLoading,
                textColor: Colors.white,
              ),
              const SizedBox(height: 24),
              RegisterText(onTap: _goToRegister)
            ],
          ),
        ),
        ),
    );
  }

  void _goToHome() {
    Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
  }

  void _goToRegister() {
    Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (_) => const RegisterScreen()),
    );
  }
}