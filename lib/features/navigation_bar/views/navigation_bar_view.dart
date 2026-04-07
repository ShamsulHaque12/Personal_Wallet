import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:personal_wallet/features/navigation_bar/controller/navigation_bar_controller.dart';
class NavigationBarView extends StatelessWidget {
  NavigationBarView({super.key});
  final NavigationBarController controller = Get.put(NavigationBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
      bottomNavigationBar: _buildBottomNav(context),
      extendBody: true,
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer.withOpacity(0.8),
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(context, Icons.home_rounded, 0),
          _buildNavItem(context, Icons.search_rounded, 1),
          _buildNavItem(context, Icons.swap_horiz_rounded, 2),
          _buildNavItem(context, Icons.layers_outlined, 3),
          _buildNavItem(context, Icons.person_outline_rounded, 4),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, int index) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => controller.changeIndex(index),
      child: Obx(() {
        final isActive = controller.selectedIndex.value == index;
        return Container(
          padding: EdgeInsets.all(isActive ? 12 : 8),
          decoration: BoxDecoration(
            color: isActive ? theme.colorScheme.primary : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon, 
            color: isActive ? Colors.white : theme.colorScheme.onSurface.withOpacity(0.4),
            size: 28.sp,
          ),
        );
      }),
    );
  }
}

