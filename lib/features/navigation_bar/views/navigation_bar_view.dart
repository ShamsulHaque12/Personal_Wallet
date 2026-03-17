import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:personal_wallet/features/navigation_bar/controller/navigation_bar_controller.dart';
import 'package:personal_wallet/theme/app_colors.dart';

class NavigationBarView extends StatelessWidget {
  NavigationBarView({super.key});
  final NavigationBarController controller = Get.put(NavigationBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
      bottomNavigationBar: _buildBottomNav(),
      extendBody: true,
    );
  }

  Widget _buildBottomNav() {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(Icons.home, 0),
          _buildNavItem(Icons.search, 1),
          _buildNavItem(Icons.swap_horiz, 2),
          _buildNavItem(Icons.layers_outlined, 3),
          _buildNavItem(Icons.person_outline, 4),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () => controller.changeIndex(index),
      child: Obx(() {
        final isActive = controller.selectedIndex.value == index;
        return Container(
          padding: EdgeInsets.all(isActive ? 12 : 8),
          decoration: BoxDecoration(
            color: isActive ? AppColors.backgroundColor : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.black, size: 28.sp),
        );
      }),
    );
  }
}
