import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_wallet/theme/app_colors.dart';
import 'package:personal_wallet/theme/app_images.dart';

class OnlineRegistrationScreen extends StatelessWidget {
  const OnlineRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              AppImages.track,
              width: 200,
              height: 200,
              color: AppColors.backgroundColor,
            ),
          ),
          SizedBox(height: 12.h),
          Center(
            child: Text(
              'Track your expenses',
              style: GoogleFonts.poppins(
                fontSize: 24.sp,
                color: AppColors.blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
