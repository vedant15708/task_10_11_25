import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/colors.dart';
import 'package:flutter/services.dart';

class AddressTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final int maxLines; // <-- ADD THIS
  final int minLines; // <-- ADD THIS
  final List<TextInputFormatter>? inputFormatters;

  const AddressTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1, // <-- ADD DEFAULT
    this.minLines = 1,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        maxLines: maxLines, // <-- PASS IT HERE
        minLines: minLines, // <-- PASS IT HERE
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14.sp, color: AppColors.grey),
          suffixIcon: suffixIcon != null
              ? Icon(suffixIcon, color: AppColors.grey, size: 20.sp)
              : null,
          filled: true,
          fillColor: AppColors.scaffoldBackground,
          contentPadding:
          EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: AppColors.primaryGreen, width: 1.w),
          ),
        ),
      ),
    );
  }
}

