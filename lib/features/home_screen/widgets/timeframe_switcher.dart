import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_wallet/features/home_screen/controller/home_screen_controller.dart';

class TimeframeSwitcher extends StatelessWidget {
  TimeframeSwitcher({super.key});
  final HomeScreenController controller = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(4.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          _buildTabItem(context, 'Daily'),
          _buildTabItem(context, 'Weekly'),
          _buildTabItem(context, 'Monthly'),
        ],
      ),
    );
  }

  Widget _buildTabItem(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(title),
        child: Obx(() {
          final isSelected = controller.selectedTab.value == title;
          return Container(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? theme.colorScheme.primary
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12.r),
            ),
            alignment: Alignment.center,
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: isSelected
                    ? Colors.white
                    : theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          );
        }),
      ),
    );
  }
}
