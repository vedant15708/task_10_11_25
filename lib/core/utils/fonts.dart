import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';

class     AppTextStyles {
  static const String _fontFamily = 'MyriadPro';
  static const String _fontFamilyCondensed = 'MyriadProCond';


  static final TextStyle onboardingTitle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static final TextStyle onboardingDescription = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textGrey,
  );

  static final TextStyle skipButton = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
    fontSize: 16.sp,
  );

  static final TextStyle primaryButton = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );


  static final TextStyle condensedExample = TextStyle(
    fontFamily: _fontFamilyCondensed,
    fontWeight: FontWeight.bold,
    fontSize: 22.sp,
    color: AppColors.primary,
  );


  static final TextStyle verificationcodedescription = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );
}