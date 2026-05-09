import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_project_kintkin/Pages/home_screen.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/auth_logo.dart';
import '../widgets/primary_button.dart';
import '../widgets/LoginText.dart';
import '../pages/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
 
 
  
  bool _isLoading = false;

  @override
  void dispose(){
   
    _emailController.dispose();
    
    _passwordController.dispose();
    
    super.dispose();


  }

  Future<void> _handleLogin() async{
    

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds:1));
    if(!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Wellcome back! ')),
  
    );
  
    
 
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));

    if(!mounted)return;

    setState(()=> _isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Email has been registered: ${_emailController.text}')),
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
              const SizedBox(height: 1000),
              const AuthLogo(),
              const SizedBox(height: 28),
              Text('Login', style: AppTextStyles.heading),
              const SizedBox(height: 8),
              Text(
                'Login to existing account',
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
              obscureText: true,
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                text: 'Login',
                onPressed: _handleLogin,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 24),
              LoginText(onTap: _goToHome)
            ],
          ),
        ),
        ),
    );
  }

  void _goToHome() {
    Navigator.push(context,
      MaterialPageRoute(builder: (_) => const homeScreen()),
    );
  }
}