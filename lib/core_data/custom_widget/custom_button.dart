import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final double radius;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;
  final double? width;
  final double? fontSize;
  final Color? borderColor;
  final double? borderWidth;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double iconSpacing;

  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.radius = 10,
    this.backgroundColor,
    this.textColor,
    this.height,
    this.width,
    this.fontSize,
    this.borderColor,
    this.borderWidth,
    this.prefixIcon,
    this.suffixIcon,
    this.iconSpacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 44.h,
        width: width ?? double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.blue,
          borderRadius: BorderRadius.circular(radius.r),
          border: Border.all(
            color: borderColor ?? Colors.white,
            width: borderWidth ?? 0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (prefixIcon != null) ...[
              prefixIcon!,
              SizedBox(width: iconSpacing),
            ],
            Text(
              text,
              style: GoogleFonts.poppins(
                color: textColor ?? Colors.white,
                fontSize: fontSize ?? 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (suffixIcon != null) ...[
              SizedBox(width: iconSpacing),
              suffixIcon!,
            ],
          ],
        ),
      ),
    );
  }
}
