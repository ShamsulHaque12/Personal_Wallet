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
import 'package:personal_wallet/features/home_screen/widgets/tilt_3d_container.dart';
import 'package:personal_wallet/features/transactions/views/flipping_3d_list_item.dart';

class OnlineRegistrationScreen extends StatelessWidget {
  const OnlineRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 3D Interactive Logo Card
            Flipping3DListItem(
              index: 0,
              child: Tilt3DContainer(
                child: Container(
                  padding: EdgeInsets.all(24.r),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: 0.03,
                      ),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        AppImages.track,
                        width: 100.w,
                        height: 100.w,
                        color: theme.colorScheme.primary,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Track your expenses, manage your budget, and grow your savings — all in one place.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 15.sp,
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.6,
                          ),
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 48.h),

            // Continue with Email Button (Cascading 3D)
            Flipping3DListItem(
              index: 1,
              child: CustomButton(
                text: 'Continue with Email',
                prefixIcon: SvgPicture.asset(
                  AppIcons.email,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
                backgroundColor: theme.colorScheme.onSurface,
                textColor: theme.colorScheme.surface,
                onTap: () {
                  Get.toNamed(AppRoutes.logInScreen);
                },
              ),
            ),
            SizedBox(height: 12.h),

            // Google Button (Cascading 3D)
            Flipping3DListItem(
              index: 2,
              child: CustomButton(
                text: 'Google',
                prefixIcon: SvgPicture.asset(AppIcons.google),
                backgroundColor: theme.colorScheme.primary,
                onTap: () {
                  Get.offAllNamed(AppRoutes.navigationBar);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
