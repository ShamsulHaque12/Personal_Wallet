import 'package:flutter/material.dart';
import 'package:personal_wallet/features/transactions/views/add_transaction_bottom_sheet.dart';
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
      margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 24.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildNavItem(context, Icons.dashboard_rounded, 'Home', 0),
          _buildNavItem(context, Icons.history, 'History', 1),
          _buildFabItem(context),
          _buildNavItem(context, Icons.bar_chart_rounded, 'Analytics', 3),
          _buildNavItem(context, Icons.person_outline_rounded, 'Profile', 4),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    int index,
  ) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => controller.changeIndex(index),
      behavior: HitTestBehavior.opaque,
      child: Obx(() {
        final isActive = controller.selectedIndex.value == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isActive
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface.withValues(alpha: 0.4),
                size: 24.sp,
              ),
              SizedBox(height: 4.h),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  color: isActive
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface.withValues(alpha: 0.4),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildFabItem(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        _showQuickAddBottomSheet(context);
      },
      child: Container(
        height: 48.w,
        width: 48.w,
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withValues(alpha: 0.4),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(Icons.add, color: Colors.white, size: 28.sp),
      ),
    );
  }

  void _showQuickAddBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddTransactionBottomSheet(),
    );
  }
}
