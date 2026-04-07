import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_wallet/features/settings/controller/settings_controller.dart';
class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final SettingsController controller = Get.put(SettingsController());

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
                        'Settings',
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
                          _buildSectionTitle(context, 'App Settings'),
                          _buildSettingTile(
                            context: context,
                            title: 'Notifications',
                            icon: Icons.notifications_active_rounded,
                            trailing: Obx(() => Switch(
                              value: controller.isNotificationsEnabled.value,
                              onChanged: controller.toggleNotifications,
                              activeColor: theme.colorScheme.primary,
                            )),
                          ),


                          SizedBox(height: 32.h),

                          _buildSectionTitle(context, 'General'),
                          _buildSettingTile(
                            context: context,
                            title: 'Language',
                            icon: Icons.language_rounded,
                            trailing: Obx(() => Text(
                              controller.selectedLanguage.value,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: theme.colorScheme.primary,
                              ),
                            )),
                            onTap: () {
                              _showSelectionDialog(
                                context,
                                'Language',
                                ['English', 'Bengali', 'Spanish'],
                                (val) => controller.changeLanguage(val),
                              );
                            },
                          ),
                          _buildSettingTile(
                            context: context,
                            title: 'Currency',
                            icon: Icons.monetization_on_rounded,
                            trailing: Obx(() => Text(
                              controller.selectedCurrency.value,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: theme.colorScheme.primary,
                              ),
                            )),
                            onTap: () {
                              _showSelectionDialog(
                                context,
                                'Currency',
                                ['USD', 'BDT', 'EUR'],
                                (val) => controller.changeCurrency(val),
                              );
                            },
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

  Widget _buildSettingTile({
    required BuildContext context,
    required String title,
    required IconData icon,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(12.r),
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
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }

  void _showSelectionDialog(
    BuildContext context,
    String title,
    List<String> options,
    Function(String) onSelect,
  ) {
    final theme = Theme.of(context);
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.r),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(35.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select $title',
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: theme.textTheme.bodyLarge?.color,
              ),
            ),
            SizedBox(height: 20.h),
            ...options.map((opt) => ListTile(
              title: Text(
                opt, 
                style: GoogleFonts.poppins(
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
              trailing: Icon(
                Icons.check_circle_outline_rounded,
                color: theme.colorScheme.primary,
              ),
              onTap: () {
                onSelect(opt);
                Get.back();
              },
            )),
          ],
        ),
      ),
    );
  }
}

