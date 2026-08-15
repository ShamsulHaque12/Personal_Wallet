import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_wallet/features/profile_screen/controller/profile_controller.dart';
import 'package:personal_wallet/features/home_screen/widgets/tilt_3d_container.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.onSurface,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16.w, top: 8.h, bottom: 8.h),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: IconButton(
              icon: Icon(
                Icons.notifications_none_rounded,
                color: theme.colorScheme.onSurface,
                size: 20.sp,
              ),
              padding: EdgeInsets.zero,
              onPressed: () {
                Get.snackbar(
                  'Notifications',
                  'You have no new notifications.',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: theme.colorScheme.surface.withValues(
                    alpha: 0.95,
                  ),
                  colorText: theme.colorScheme.onSurface,
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Horizontal Profile Row
              Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(3.r),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.colorScheme.primary.withValues(
                              alpha: 0.3,
                            ),
                            width: 1.5,
                          ),
                        ),
                        child: Obx(
                          () => CircleAvatar(
                            radius: 36.r,
                            backgroundColor: theme.colorScheme.surface,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(36.r),
                              child: controller.avatarUrl.value.isNotEmpty
                                  ? Image.network(
                                      controller.avatarUrl.value,
                                      fit: BoxFit.cover,
                                      width: 72.r,
                                      height: 72.r,
                                      errorBuilder:
                                          (context, error, stackTrace) => Icon(
                                            Icons.broken_image_rounded,
                                            size: 28.sp,
                                            color: theme.colorScheme.onSurface
                                                .withValues(alpha: 0.4),
                                          ),
                                    )
                                  : Icon(
                                      Icons.broken_image_rounded,
                                      size: 28.sp,
                                      color: theme.colorScheme.onSurface
                                          .withValues(alpha: 0.4),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            controller.userName.value.isEmpty
                                ? 'User Name'
                                : controller.userName.value,
                            style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Obx(
                          () => Text(
                            controller.userGmail.value.isEmpty
                                ? 'user@example.com'
                                : controller.userGmail.value,
                            style: GoogleFonts.poppins(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.5,
                              ),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Dual Credit-Card Style Stats with 3D Tilt Effect
              Row(
                children: [
                  Expanded(
                    child: Tilt3DContainer(
                      child: Container(
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.05,
                            ),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.01),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(6.r),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withValues(
                                  alpha: 0.1,
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Icon(
                                Icons.account_balance_wallet_rounded,
                                size: 16.sp,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              'Total Balance',
                              style: GoogleFonts.poppins(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500,
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.5,
                                ),
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Obx(
                              () => Text(
                                controller.totalBalance.value,
                                style: GoogleFonts.poppins(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Tilt3DContainer(
                      child: Container(
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.05,
                            ),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.01),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(6.r),
                              decoration: BoxDecoration(
                                color: Colors.blue.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Icon(
                                Icons.savings_rounded,
                                size: 16.sp,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              'Monthly Savings',
                              style: GoogleFonts.poppins(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500,
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.5,
                                ),
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Obx(
                              () => Text(
                                controller.monthlySavings.value,
                                style: GoogleFonts.poppins(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Grouped Settings List
              _buildSectionHeader('Account Settings', theme),
              _buildFlatMenuItem(
                context: context,
                icon: Icons.person_outline_rounded,
                iconColor: theme.colorScheme.primary,
                label: 'Edit Profile',
                onTap: controller.onEditProfile,
              ),
              _buildFlatMenuItem(
                context: context,
                icon: Icons.lock_outline_rounded,
                iconColor: Colors.blue,
                label: 'Security',
                onTap: controller.onSecurity,
                showDivider: false,
              ),
              SizedBox(height: 12.h),

              _buildSectionHeader('Preferences & Support', theme),
              _buildFlatMenuItem(
                context: context,
                icon: Icons.settings_outlined,
                iconColor: Colors.amber,
                label: 'Settings',
                onTap: controller.onSetting,
              ),
              _buildFlatMenuItem(
                context: context,
                icon: Icons.help_outline_rounded,
                iconColor: Colors.purple,
                label: 'Help Center',
                onTap: controller.onHelp,
                showDivider: false,
              ),
              SizedBox(height: 12.h),

              _buildSectionHeader('Session', theme),
              _buildFlatMenuItem(
                context: context,
                icon: Icons.logout_rounded,
                iconColor: Colors.redAccent,
                label: 'Logout',
                textColor: Colors.redAccent,
                onTap: controller.onLogout,
                showDivider: false,
                trailing: const SizedBox.shrink(),
              ),

              SizedBox(height: 80.h), // Safe spacing for persistent navbar
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
          color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
          letterSpacing: 1.1,
        ),
      ),
    );
  }

  Widget _buildFlatMenuItem({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String label,
    required VoidCallback onTap,
    bool showDivider = true,
    Color? textColor,
    Widget? trailing,
  }) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
              child: Row(
                children: [
                  Icon(icon, color: iconColor, size: 22.sp),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Text(
                      label,
                      style: GoogleFonts.poppins(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: textColor ?? theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  trailing ??
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 20.sp,
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.3,
                        ),
                      ),
                ],
              ),
            ),
            if (showDivider)
              Divider(
                height: 1,
                indent: 46.w,
                endIndent: 8.w,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
              ),
          ],
        ),
      ),
    );
  }
}
