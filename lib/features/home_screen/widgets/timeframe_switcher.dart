import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_wallet/features/home_screen/controller/home_screen_controller.dart';
import 'package:personal_wallet/theme/app_colors.dart';

class TimeframeSwitcher extends StatelessWidget {
  TimeframeSwitcher({super.key});
  final HomeScreenController controller = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.h),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Row(
        children: [
          _buildTabItem('Daily'),
          _buildTabItem('Weekly'),
          _buildTabItem('Monthly'),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(title),
        child: Obx(() {
          final isSelected = controller.selectedTab.value == title;
          return Container(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.backgroundColor : Colors.transparent,
              borderRadius: BorderRadius.circular(20.r),
            ),
            alignment: Alignment.center,
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Colors.black : Colors.black54,
              ),
            ),
          );
        }),
      ),
    );
  }
}
