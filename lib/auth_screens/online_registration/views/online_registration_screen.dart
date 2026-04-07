import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_wallet/core_data/custom_widget/custom_button.dart';
import 'package:personal_wallet/route/app_routes.dart';
import 'package:personal_wallet/theme/app_icons.dart';
import 'package:personal_wallet/theme/app_images.dart';

class OnlineRegistrationScreen extends StatelessWidget {
  const OnlineRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                AppImages.track,
                width: 180,
                height: 180,
                color: theme.colorScheme.primary,
              ),
            ),
            SizedBox(height: 12.h),
            Center(
              child: Text(
                'Track your expenses, manage your budget, and grow your savings — all in one place.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  color: theme.textTheme.bodyLarge?.color,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 24.h),
            CustomButton(
              text: 'Google',
              prefixIcon: SvgPicture.asset(AppIcons.google),
              backgroundColor: theme.colorScheme.primary,
              onTap: () {
                Get.offAllNamed(AppRoutes.navigationBar);
              },
            ),
            SizedBox(height: 12.h),
            CustomButton(
              text: 'Apple',
              prefixIcon: SvgPicture.asset(AppIcons.apple, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
              backgroundColor: theme.colorScheme.onSurface,
              textColor: theme.colorScheme.surface,
              onTap: () {},
            ),
            SizedBox(height: 12.h),
            CustomButton(
              text: 'Facebook',
              prefixIcon: SvgPicture.asset(AppIcons.facebook),
              backgroundColor: const Color(0xFF1877F2),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

