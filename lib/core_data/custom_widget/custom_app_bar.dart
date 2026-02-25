import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBack;
  final VoidCallback? onBackTap;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? titleColor;
  final double? elevation;
  final double? scrolledElevation;

  const CustomAppBar({
    super.key,
    this.title,
    this.showBack = true,
    this.onBackTap,
    this.actions,
    this.backgroundColor,
    this.titleColor,
    this.elevation,
    this.scrolledElevation,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.white,
      elevation: elevation ?? 0,
      scrolledUnderElevation: scrolledElevation ?? 2,
      centerTitle: true,
      leading: showBack
          ? IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          size: 20.sp,
          color: Colors.black,
        ),
        onPressed: onBackTap ?? () => Navigator.pop(context),
      )
          : null,
      title: title == null
          ? null
          : Text(
        title!,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: titleColor ?? Colors.black,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
