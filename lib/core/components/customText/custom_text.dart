import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task_scheduling_app/core/app_utils/app_colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxlines;
  final TextDecoration? underline;
  const CustomText({
    super.key,
    required this.text,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.overflow,
    this.maxlines,
    this.underline,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textScaler: const TextScaler.linear(1.0),
      style: TextStyle(
          fontFamily: fontFamily ?? 'SafeGoogleFont',
          decoration: underline,
          decorationColor: AppColors.primaryBlack,
          fontWeight: fontWeight ?? FontWeight.normal,
          overflow: overflow,
          letterSpacing: -0.48,
          color: textColor,
          fontSize: fontSize ?? 16.sp),
    );
  }
}
