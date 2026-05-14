import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/auth_logo.dart';
import '../widgets/primary_button.dart';
import '../widgets/LoginText.dart';
import 'login_screen.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
    super.dispose();


  }

  Future<void> _handleRegister() async{
    if(_passwordController.text != _confirmPasswordController.text){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds:1));
    if(!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Email has been Registered: ${_emailController.text}')),
  
    );
  
    
 
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));

    if(!mounted)return;

    setState(()=> _isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Email has been registered: ${_emailController.text}')),
    );

    _goToLogin();


  }

  void _goToLogin(){
     Navigator.push(context,
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
              obscureText: true,
              ),
              const SizedBox(height: 20),
              CustomTextField(
              label:'Re-Enter Password' , 
              hintText: '.....', 
              icon: Icons.lock_outlined,
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
              LoginText(onTap: _goToLogin)
            ],
          ),
        ),
        ),
    );
  }
}