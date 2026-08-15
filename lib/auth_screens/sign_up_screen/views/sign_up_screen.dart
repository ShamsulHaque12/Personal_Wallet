import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_wallet/auth_screens/sign_up_screen/controller/sign_up_controller.dart';
import 'package:personal_wallet/route/app_routes.dart';
import 'package:personal_wallet/features/home_screen/widgets/tilt_3d_container.dart';
import 'package:personal_wallet/features/transactions/views/flipping_3d_list_item.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final SignUpController controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left_rounded,
            color: theme.colorScheme.onSurface,
            size: 28.sp,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create Account',
              style: GoogleFonts.poppins(
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Sign up to start tracking your finances.',
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
            SizedBox(height: 28.h),

            // 3D Credentials Card
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name Field
                      Text(
                        'Full Name',
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.6,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        decoration: BoxDecoration(
                          color: theme.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.05,
                            ),
                            width: 1.5,
                          ),
                        ),
                        child: TextField(
                          controller: controller.nameController,
                          keyboardType: TextInputType.name,
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            color: theme.colorScheme.onSurface,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: Icon(
                                Icons.person_outline_rounded,
                                color: theme.colorScheme.primary,
                                size: 20.sp,
                              ),
                            ),
                            prefixIconConstraints: const BoxConstraints(),
                            hintText: 'Enter your name',
                            hintStyle: GoogleFonts.poppins(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.35,
                              ),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 14.h,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Email Field
                      Text(
                        'Email Address',
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.6,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        decoration: BoxDecoration(
                          color: theme.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.05,
                            ),
                            width: 1.5,
                          ),
                        ),
                        child: TextField(
                          controller: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            color: theme.colorScheme.onSurface,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: Icon(
                                Icons.mail_outline_rounded,
                                color: theme.colorScheme.primary,
                                size: 20.sp,
                              ),
                            ),
                            prefixIconConstraints: const BoxConstraints(),
                            hintText: 'Enter your email',
                            hintStyle: GoogleFonts.poppins(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.35,
                              ),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 14.h,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Password Field
                      Text(
                        'Password',
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.6,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        decoration: BoxDecoration(
                          color: theme.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.05,
                            ),
                            width: 1.5,
                          ),
                        ),
                        child: Obx(
                          () => TextField(
                            controller: controller.passwordController,
                            obscureText: !controller.isPasswordVisible.value,
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: theme.colorScheme.onSurface,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                child: Icon(
                                  Icons.lock_outline_rounded,
                                  color: theme.colorScheme.primary,
                                  size: 20.sp,
                                ),
                              ),
                              prefixIconConstraints: const BoxConstraints(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.isPasswordVisible.value
                                      ? Icons.visibility_off_rounded
                                      : Icons.visibility_rounded,
                                  color: theme.colorScheme.onSurface.withValues(
                                    alpha: 0.4,
                                  ),
                                  size: 20.sp,
                                ),
                                onPressed: controller.togglePasswordVisibility,
                              ),
                              hintText: 'Enter password',
                              hintStyle: GoogleFonts.poppins(
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.35,
                                ),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 14.h,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Confirm Password Field
                      Text(
                        'Confirm Password',
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.6,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        decoration: BoxDecoration(
                          color: theme.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.05,
                            ),
                            width: 1.5,
                          ),
                        ),
                        child: Obx(
                          () => TextField(
                            controller: controller.confirmPasswordController,
                            obscureText: !controller.isConfirmPasswordVisible.value,
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: theme.colorScheme.onSurface,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                child: Icon(
                                  Icons.lock_outline_rounded,
                                  color: theme.colorScheme.primary,
                                  size: 20.sp,
                                ),
                              ),
                              prefixIconConstraints: const BoxConstraints(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.isConfirmPasswordVisible.value
                                      ? Icons.visibility_off_rounded
                                      : Icons.visibility_rounded,
                                  color: theme.colorScheme.onSurface.withValues(
                                    alpha: 0.4,
                                  ),
                                  size: 20.sp,
                                ),
                                onPressed: controller.toggleConfirmPasswordVisibility,
                              ),
                              hintText: 'Confirm password',
                              hintStyle: GoogleFonts.poppins(
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.35,
                                ),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 14.h,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 28.h),

            // Sign Up Button
            Flipping3DListItem(
              index: 1,
              child: Obx(
                () => GestureDetector(
                  onTap: controller.isLoading.value ? null : controller.signUp,
                  child: Container(
                    width: double.infinity,
                    height: 52.h,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(
                        alpha: controller.isLoading.value ? 0.7 : 1.0,
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Center(
                      child: controller.isLoading.value
                          ? SizedBox(
                              height: 22.r,
                              width: 22.r,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                          : Text(
                              'Sign Up',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Redirect back to Login link
            Center(
              child: GestureDetector(
                onTap: () => Get.offNamed(AppRoutes.logInScreen),
                child: RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: GoogleFonts.poppins(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                      fontSize: 14.sp,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign In',
                        style: GoogleFonts.poppins(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
