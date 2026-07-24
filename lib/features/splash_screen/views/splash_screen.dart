import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_wallet/features/splash_screen/controller/splash_controller.dart';
import 'package:personal_wallet/theme/app_images.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset(AppImages.track, width: 200, height: 200)),
          SizedBox(height: 12.h),
          Center(
            child: Text(
              'Track your expenses',
              style: GoogleFonts.poppins(
                fontSize: 24.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Text(
              'and save your money',
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                color: Colors.white.withValues(alpha: 0.7),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 30.h),
          Center(
            child: SpinKitCircle(color: Colors.white, size: 60.sp),
          ),
        ],
      ),
    );
  }
}
