import 'package:flutter/material.dart';
import '../theme/app_text.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color? textColor;
  final TextStyle? textStyle;
  final Color? bgColor;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.bgColor,
    this.isLoading = false,
    this.textColor,
    this.textStyle,
  }); // ← this closing ); was missing

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(30),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                text,
                style: textStyle ?? AppTextStyles.button.copyWith(
                  color: textColor,
                ),
              ),
      ),
    );
  }
}