import 'package:flutter/material.dart';

import '../theme/app_text.dart';
class LoginText extends StatelessWidget {
  final VoidCallback onTap;
  const LoginText({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already Have an Account? ',
          style: AppTextStyles.bodyText,
        ),
        GestureDetector(
          onTap: onTap,
          child: const Text('Login Here!', style: AppTextStyles.linkText),
        ),
      ],
    );
  }
}

class RegisterText extends StatelessWidget {
  final VoidCallback onTap;
  const RegisterText({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't Have an Account? ",
          style: AppTextStyles.bodyText,
        ),
        GestureDetector(
          onTap: onTap,
          child: const Text('Register Here!', style: AppTextStyles.linkText),
        ),
      ],
    );
  }
}