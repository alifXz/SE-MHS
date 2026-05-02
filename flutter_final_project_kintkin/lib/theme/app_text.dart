import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles{
  AppTextStyles._();
  //Info:
  //Text 1 : itu text utama
  //Text 2 : itu buat subtitle
  //Textbg: itu buat yg di background

  static const TextStyle heading = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.text1,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 15,
    color: AppColors.text2,
  );

  static const TextStyle label = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.text1,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize:  14,
    color: AppColors.text2,

  );

  static const TextStyle linkText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600
    color: AppColors.text1,
  );


}