import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_wallet/features/security/controller/security_controller.dart';
class SecurityScreen extends StatelessWidget {
  SecurityScreen({super.key});

  final SecurityController controller = Get.put(SecurityController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Stack(
        children: [
          // Teal Header
          Container(
            height: 200.h,
            width: double.infinity,
            color: theme.colorScheme.background,
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                // Header Row
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Row(
                    children: [
                      const BackButton(color: Colors.white),
                      SizedBox(width: 8.w),
                      Text(
                        'Security',
                        style: GoogleFonts.poppins(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                // Content Body
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(24.r),
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35.r),
                        topRight: Radius.circular(35.r),
                      ),
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle(context, 'Protection'),
                          _buildSecurityTile(
                            context: context,
                            title: 'Face ID',
                            subtitle: 'Use Face ID for quick login',
                            icon: Icons.face_rounded,
                            trailing: Obx(() => Switch(
                              value: controller.isFaceIDEnabled.value,
                              onChanged: controller.toggleFaceID,
                              activeColor: theme.colorScheme.primary,
                            )),
                          ),
                          _buildSecurityTile(
                            context: context,
                            title: 'Biometric ID',
                            subtitle: 'Use fingerprint for quick login',
                            icon: Icons.fingerprint_rounded,
                            trailing: Obx(() => Switch(
                              value: controller.isBiometricEnabled.value,
                              onChanged: controller.toggleBiometric,
                              activeColor: theme.colorScheme.primary,
                            )),
                          ),

                          SizedBox(height: 32.h),

                          _buildSectionTitle(context, 'Account'),
                          _buildSecurityTile(
                            context: context,
                            title: 'Two-Factor Authentication',
                            subtitle: 'Secure your account with 2FA',
                            icon: Icons.domain_verification_rounded,
                            trailing: Obx(() => Switch(
                              value: controller.isTwoFactorEnabled.value,
                              onChanged: controller.toggleTwoFactor,
                              activeColor: theme.colorScheme.primary,
                            )),
                          ),
                          _buildSecurityTile(
                            context: context,
                            title: 'Change Password',
                            subtitle: 'Last changed 3 months ago',
                            icon: Icons.lock_outline_rounded,
                            onTap: controller.onChangePassword,
                            trailing: Icon(
                              Icons.arrow_forward_ios, 
                              size: 16,
                              color: theme.colorScheme.onSurface.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: theme.textTheme.bodyLarge?.color,
        ),
      ),
    );
  }

  Widget _buildSecurityTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, color: theme.colorScheme.primary, size: 24.sp),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: theme.textTheme.bodyLarge?.color,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            color: theme.colorScheme.onSurface.withOpacity(0.5),
          ),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}

