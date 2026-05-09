import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';

class PrimaryButton extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;
  final bool isLoading;



  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(30),
          ),
        ),
         child: isLoading ? const SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            color:Colors.white,
            strokeWidth: 2,
          ),
         )
         :Text(text,style: AppTextStyles.button),
         ),
    );
  }
}