import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_wallet/features/security/controller/security_controller.dart';
import 'package:personal_wallet/features/home_screen/widgets/tilt_3d_container.dart';
import 'package:personal_wallet/features/transactions/views/flipping_3d_list_item.dart';

class SecurityScreen extends StatelessWidget {
  SecurityScreen({super.key});

  final SecurityController controller = Get.put(SecurityController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left_rounded,
            color: theme.colorScheme.onSurface,
            size: 28.sp,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Security',
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Protection Section
              _buildSectionHeader('Protection', theme),
              Flipping3DListItem(
                index: 0,
                child: Tilt3DContainer(
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.03),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Obx(() => _buildFlatSecurityTile(
                              context: context,
                              title: 'Face ID',
                              subtitle: 'Use Face ID for quick login',
                              icon: Icons.face_rounded,
                              iconColor: theme.colorScheme.primary,
                              trailing: Switch(
                                value: controller.isFaceIDEnabled.value,
                                onChanged: controller.toggleFaceID,
                                activeThumbColor: theme.colorScheme.primary,
                                activeTrackColor: theme.colorScheme.primary.withValues(alpha: 0.2),
                              ),
                            )),
                        Obx(() => _buildFlatSecurityTile(
                              context: context,
                              title: 'Biometric ID',
                              subtitle: 'Use fingerprint for quick login',
                              icon: Icons.fingerprint_rounded,
                              iconColor: Colors.blue,
                              trailing: Switch(
                                value: controller.isBiometricEnabled.value,
                                onChanged: controller.toggleBiometric,
                                activeThumbColor: theme.colorScheme.primary,
                                activeTrackColor: theme.colorScheme.primary.withValues(alpha: 0.2),
                              ),
                              showDivider: false,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // Account Section
              _buildSectionHeader('Account Security', theme),
              Flipping3DListItem(
                index: 1,
                child: Tilt3DContainer(
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.03),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Obx(() => _buildFlatSecurityTile(
                              context: context,
                              title: 'Two-Factor Authentication',
                              subtitle: 'Secure your account with 2FA',
                              icon: Icons.domain_verification_rounded,
                              iconColor: Colors.amber,
                              trailing: Switch(
                                value: controller.isTwoFactorEnabled.value,
                                onChanged: controller.toggleTwoFactor,
                                activeThumbColor: theme.colorScheme.primary,
                                activeTrackColor: theme.colorScheme.primary.withValues(alpha: 0.2),
                              ),
                            )),
                        _buildFlatSecurityTile(
                          context: context,
                          title: 'Change Password',
                          subtitle: 'Last changed 3 months ago',
                          icon: Icons.lock_outline_rounded,
                          iconColor: Colors.purple,
                          onTap: controller.onChangePassword,
                          trailing: Icon(
                            Icons.chevron_right_rounded,
                            size: 20.sp,
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                          ),
                          showDivider: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, ThemeData theme) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w, bottom: 8.h, top: 12.h),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.poppins(
          fontSize: 11.sp,
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.primary,
          letterSpacing: 1.1,
        ),
      ),
    );
  }

  Widget _buildFlatSecurityTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    Widget? trailing,
    VoidCallback? onTap,
    bool showDivider = true,
  }) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: iconColor,
                    size: 24.sp,
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          subtitle,
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing ?? const SizedBox.shrink(),
                ],
              ),
            ),
            if (showDivider)
              Divider(
                height: 1,
                indent: 56.w,
                endIndent: 16.w,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
              ),
          ],
        ),
      ),
    );
  }
}
