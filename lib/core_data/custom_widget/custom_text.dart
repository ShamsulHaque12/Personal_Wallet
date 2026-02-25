import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  // new
  final bool underline;
  final double? letterSpacing;
  final VoidCallback? onTap;

  const CustomText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.underline = false,
    this.letterSpacing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: overflow,
      style: GoogleFonts.inter(
        fontSize: fontSize ?? 16.sp,
        fontWeight: fontWeight ?? FontWeight.w600,
        color: color ?? Colors.black,
        letterSpacing: letterSpacing,
        decoration:
        underline ? TextDecoration.underline : TextDecoration.none,
      ),
    );

    if (onTap == null) {
      return textWidget;
    }

    return GestureDetector(
      onTap: onTap,
      child: textWidget,
    );
  }
}
