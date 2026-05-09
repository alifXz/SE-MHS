import 'package:flutter/material.dart';

import '../theme/app_text.dart';
class LoginText extends StatelessWidget {
  final VoidCallback onTap;
  const LoginText({required this.onTap});

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