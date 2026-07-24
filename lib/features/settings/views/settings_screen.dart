import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_wallet/features/settings/controller/settings_controller.dart';
import 'package:personal_wallet/features/home_screen/widgets/tilt_3d_container.dart';
import 'package:personal_wallet/features/transactions/views/flipping_3d_list_item.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final SettingsController controller = Get.put(SettingsController());

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
          'Settings',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(context, 'App Settings'),
            _buildSettingsGroup(
              context,
              index: 0,
              children: [
                _buildSettingTile(
                  context: context,
                  title: 'Notifications',
                  subtitle: 'Enable push notifications',
                  icon: Icons.notifications_none_rounded,
                  iconColor: Colors.deepPurple,
                  iconBgColor: Colors.deepPurple.withValues(alpha: 0.1),
                  trailing: Obx(
                    () => Switch(
                      value: controller.isNotificationsEnabled.value,
                      onChanged: controller.toggleNotifications,
                      activeThumbColor: theme.colorScheme.primary,
                      activeTrackColor:
                          theme.colorScheme.primary.withValues(alpha: 0.2),
                    ),
                  ),
                  showDivider: false,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _buildSectionHeader(context, 'General'),
            _buildSettingsGroup(
              context,
              index: 1,
              children: [
                Obx(
                  () => _buildSettingTile(
                    context: context,
                    title: 'Language',
                    subtitle: 'Choose app language',
                    icon: Icons.language_rounded,
                    iconColor: Colors.blue,
                    iconBgColor: Colors.blue.withValues(alpha: 0.1),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          controller.selectedLanguage.value,
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.3),
                          size: 20.sp,
                        ),
                      ],
                    ),
                    onTap: () {
                      _showSelectionDialog(
                        context,
                        'Language',
                        ['English', 'Bengali'],
                        controller.selectedLanguage.value,
                        (val) => controller.changeLanguage(val),
                      );
                    },
                    showDivider: true,
                  ),
                ),
                Obx(
                  () => _buildSettingTile(
                    context: context,
                    title: 'Currency',
                    subtitle: 'Choose default currency',
                    icon: Icons.monetization_on_outlined,
                    iconColor: Colors.green,
                    iconBgColor: Colors.green.withValues(alpha: 0.1),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          controller.selectedCurrency.value,
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.3),
                          size: 20.sp,
                        ),
                      ],
                    ),
                    onTap: () {
                      _showSelectionDialog(
                        context,
                        'Currency',
                        ['BDT'],
                        controller.selectedCurrency.value,
                        (val) => controller.changeCurrency(val),
                      );
                    },
                    showDivider: false,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 16.h, bottom: 8.h),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.poppins(
          fontSize: 11.sp,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildSettingsGroup(
    BuildContext context, {
    required List<Widget> children,
    required int index,
  }) {
    final theme = Theme.of(context);
    return Flipping3DListItem(
      index: index,
      child: Tilt3DContainer(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
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
            children: children,
          ),
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
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
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: iconBgColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      icon,
                      color: iconColor,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        if (subtitle.isNotEmpty) ...[
                          SizedBox(height: 2.h),
                          Text(
                            subtitle,
                            style: GoogleFonts.poppins(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400,
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.4),
                            ),
                          ),
                        ],
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
                indent: 52.w,
                endIndent: 16.w,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
              ),
          ],
        ),
      ),
    );
  }

  void _showSelectionDialog(
    BuildContext context,
    String title,
    List<String> options,
    String currentValue,
    Function(String) onSelect,
  ) {
    final theme = Theme.of(context);
    Get.bottomSheet(
      Container(
        padding:
            EdgeInsets.only(left: 24.r, right: 24.r, top: 12.r, bottom: 24.r),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, -10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Select $title',
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 16.h),
            ...options.map((opt) {
              final isSelected = opt == currentValue;
              return Material(
                color: Colors.transparent,
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  title: Text(
                    opt,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                  trailing: isSelected
                      ? Icon(
                          Icons.check_circle_rounded,
                          color: theme.colorScheme.primary,
                          size: 20.sp,
                        )
                      : null,
                  onTap: () {
                    onSelect(opt);
                    Get.back();
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
